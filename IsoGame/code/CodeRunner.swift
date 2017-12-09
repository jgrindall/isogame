import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

class CodeRunner: NSObject, PCodeRunner, UIWebViewDelegate {

	private var _consumer:PCodeConsumer!
	private var webView:UIWebView
	
	required override init(){
		self.webView = UIWebView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		super.init()
	}
	
	func load(fileName:String) -> PCodeRunner{
		do {
			self.webView.delegate = self
			let htmlPath:String = Bundle.main.path(forResource: fileName, ofType: "html")!
			let contents:String = try String(contentsOfFile: htmlPath)
			self.webView.loadHTMLString(contents, baseURL: URL(fileURLWithPath: htmlPath))
		}
		catch (_) {
			print("Error while loading")
		}
		return self
	}
	
	func webViewDidStartLoad(_ webView: UIWebView) {
		print("webViewDidStartLoad")
	}
	
	func webView(_ webView: UIWebView, didFailLoadWithError error: Error){
		print(error as Any)
	}
	
	private func consume(jsonString:String){
		if let data:[String:Any] = jsonString.parseJSONString {
			let type = data["type"] as? String
			if type == "command"{
				self._consumer.consume(data: data)
			}
			else if(type == "error"){
				print("ERROR")
			}
		}
	}
	
	func webViewDidFinishLoad(_ webView: UIWebView){
		let ctx:JSContext = (self.webView.value(forKeyPath: "documentView.webView.mainFrame.javaScriptContext") as? JSContext)!
		let logFunction: @convention(block) (String) -> Void = { (msg: String) in
			//print("console.log", msg)
		}
		let iosCallbackFunction: @convention(block) (String) -> Void = { (msg: String) in
			self.consume(jsonString:msg)
		}
		ctx.objectForKeyedSubscript("console").setObject(unsafeBitCast(logFunction, to: AnyObject.self), forKeyedSubscript: "log" as NSCopying & NSObjectProtocol)
		ctx.objectForKeyedSubscript("iosBridge").setObject(unsafeBitCast(iosCallbackFunction, to: AnyObject.self), forKeyedSubscript: "callback" as NSCopying & NSObjectProtocol)
		//run(fnName: "setDelay", arg: "50")
		self._consumer.ready()
	}
	
	func setConsumer(consumer:PCodeConsumer) -> PCodeRunner{
		self._consumer = consumer
		return self
	}
	
	public func run(fnName:String) {
		let s:String = fnName + "()"
		print("stringByEvaluatingJavaScript", s)
		self.webView.stringByEvaluatingJavaScript(from: s)
	}
	
	public func run(fnName:String, arg:String) {
		let s:String = fnName + "(\'" + arg + "\')"
		print("stringByEvaluatingJavaScript", s)
		self.webView.stringByEvaluatingJavaScript(from: s)
	}
}
