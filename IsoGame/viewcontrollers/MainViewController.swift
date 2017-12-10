
import UIKit
import SpriteKit

class MainViewController: UIViewController {
	
	var gameViewController: GameViewController
	var gameView:UIView?
	var playStop:UIButton?
	
	init(){
		gameViewController = GameViewController()
		super.init(nibName: nil, bundle: nil)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()
		view.backgroundColor = .green
		addGame()
		addUI()
    }
	
	func addUI(){
		playStop = UIButton(type: UIButtonType.system)
		playStop?.setTitle("play", for: UIControlState.normal)
		playStop?.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
		playStop?.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
		self.view.addSubview(playStop!)
	}
	
	@objc func playTapped(sender: UIButton!) {
		gameViewController.start()
	}
	
	func addGame(){
		gameViewController.view.frame = self.view.frame
		addChildViewController(gameViewController)
		view.addSubview(gameViewController.view)
		gameViewController.didMove(toParentViewController: self)
	}
	
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
