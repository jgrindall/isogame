
import UIKit
import SpriteKit

class GameViewController: UIViewController, PCodeConsumer {
	
	var skView:SKView? = nil
	var scene:GameScene? = nil
	var codeRunner:PCodeRunner
	var _status:String = "stopped"
	
	init(){
		codeRunner = CodeRunner()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
	}
	
	override func loadView() {
		super.loadView()
	}
	
	func ready(){
		print("ready")
	}
	
	func stop(){
		_status = "stopping"
		codeRunner.run(fnName: "stop")
	}
	
	func start(){
		let dictionary:[String : Any] = Logo.getInput()
		if let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
			let theJSONText = String(data: theJSONData, encoding: .ascii)
			_status = "running"
			codeRunner.run(fnName: "run", arg: theJSONText!)
		}
	}
	
	func onError(){
		_status = "stopped"
	}
	
	func consume(data: [String:Any]) {
		print("consume")
		let type = data["type"] as? String
		if type == "command"{
			scene?.consume(data:data)
		}
		else if(type == "error"){
			// mode change
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .red
		scene = GameScene(size: view.bounds.size)
		skView = SKView(frame: CGRect(origin: CGPoint(x:0,y:0), size: view.bounds.size))
        skView?.showsFPS = true
        skView?.showsNodeCount = true
        skView?.ignoresSiblingOrder = true
        scene?.scaleMode = .resizeFill
        skView?.presentScene(scene)
		self.view.addSubview(skView!)
		_ = codeRunner.setConsumer(consumer: self).load(fileName: "index")
    }
	
}
