
import UIKit
import SpriteKit

class GameViewController: UIViewController {
	
	var skView:SKView? = nil
	var scene:GameScene? = nil
	
	init(){
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
	
	func start(){
		scene?.start()
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
    }
	
}
