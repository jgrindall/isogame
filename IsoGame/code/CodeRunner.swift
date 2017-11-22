import Foundation
import SceneKit
import QuartzCore
import JavaScriptCore
import UIKit

@objc
class CodeRunner : NSObject, PCodeRunner {

	private var context: JSContext!
	private let serialQueue = DispatchQueue(label: "codeRunnerSerialQueue" + UUID().uuidString)
	private var _consumer:PCodeConsumer!
	
	enum CodeRunnerError : Error {
		case RuntimeError(String)
	}
	
	func setConsumer(consumer:PCodeConsumer){
		self._consumer = consumer
		self._bindConsumer()
	}
	
	required init(fileNames:[String]){
		super.init()
		self._makeContext(fileNames: fileNames)
		self._loadFiles(fileNames: fileNames)
	}
	
	private func loadFile(fileName:String){
		do {
			let path:String = Bundle.main.path(forResource: fileName, ofType: "js")!
			let contents = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
			_ = self.context.evaluateScript(contents)
		}
		catch (let error) {
			print("Error while processing script file: \(error)")
		}
	}
	
	private func _loadFiles(fileNames:[String]){
		for fileName:String in fileNames{
			self.loadFile(fileName:fileName)
		}
	}
	
	private func _makeContext(fileNames:[String]){
		self.context = JSContext(virtualMachine: JSVirtualMachine());
		let consoleLog: @convention(block) (String) -> Void = { message in
			print("console.log " + message)
		}
		self.context.exceptionHandler = { context, exception in
			print("error: \(String(describing: exception))")
		};
		self.context.globalObject.setObject(unsafeBitCast(consoleLog, to: AnyObject.self), forKeyedSubscript: "consoleLog" as (NSCopying & NSObjectProtocol)!)
	}
	
	private func _bindConsumer(){
		let lockedConsumerBlock:@convention(block)(String, String) ->Void = {type, data in
			self._consumer.consume(type: type, data:data)
		}
		let castBlock:Any! = unsafeBitCast(lockedConsumerBlock, to: AnyObject.self);
		self.context.globalObject.setObject(castBlock, forKeyedSubscript: "consumer" as (NSCopying & NSObjectProtocol)!)
	}
	
	private func _unbindConsumer(){
		self.context.globalObject.setObject(nil, forKeyedSubscript: "consumer" as (NSCopying & NSObjectProtocol)!)
	}
	
	public func run(fnName:String, arg:String) {
		serialQueue.async{
			let fn = self.context.objectForKeyedSubscript(fnName)
			_ = fn?.call(withArguments: [arg])
		}
	}
}

