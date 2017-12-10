
import UIKit
import SpriteKit

class MainViewController: UIViewController {
	
	var gameViewController: GameViewController
	var gameView:UIView?
	var playButton:UIButton?
	var stopButton:UIButton?
	
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
		playButton = UIButton(type: UIButtonType.system)
		playButton?.setTitle("play", for: UIControlState.normal)
		playButton?.frame = CGRect(x: 50, y: 50, width: 200, height: 50)
		playButton?.addTarget(self, action: #selector(playTapped), for: .touchUpInside)
		self.view.addSubview(playButton!)
		stopButton = UIButton(type: UIButtonType.system)
		stopButton?.setTitle("stop", for: UIControlState.normal)
		stopButton?.frame = CGRect(x: 150, y: 50, width: 200, height: 50)
		stopButton?.addTarget(self, action: #selector(stopTapped), for: .touchUpInside)
		self.view.addSubview(stopButton!)
	}
	
	@objc func playTapped(sender: UIButton!) {
		gameViewController.start()
	}
	
	@objc func stopTapped(sender: UIButton!) {
		gameViewController.stop()
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
