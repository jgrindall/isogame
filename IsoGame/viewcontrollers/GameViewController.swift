
import UIKit
import SpriteKit

class GameViewController: UIViewController {
	
	override func viewDidLoad() {
        super.viewDidLoad()
        let scene = GameScene(size: view.bounds.size)
		self.view = SKView(frame: CGRect(origin: CGPoint(x:0,y:0), size: view.bounds.size))
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
