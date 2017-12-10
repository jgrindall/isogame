
import UIKit
import SpriteKit

class GameScene: SKScene, PCodeConsumer  {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var charList : CharacterList
	var viewIso:SKSpriteNode
    var groundLayer:SKNode
    var objectsLayer:SKNode
    
    let nthFrame = 6
    var nthFrameCount = 0
	var codeRunner:PCodeRunner
	var SIZE = 6
	
    override init(size: CGSize) {
		charList = CharacterList()
		viewIso = SKSpriteNode()
        groundLayer = SKNode()
        objectsLayer = SKNode()
		codeRunner = CodeRunner()
		super.init(size: size)
	}
	
    override func didMove(to view: SKView) {
		self.backgroundColor = .purple
		viewIso.position = CGPoint(x:0, y:0)
        viewIso.addChild(groundLayer)
        viewIso.addChild(objectsLayer)
		Projections.setupSize(w:(self.view?.frame.width)!, h: (self.view?.frame.height)!)
        addChild(viewIso)
		makeGround()
		makeCharacters()
		_ = codeRunner.setConsumer(consumer: self).load(fileName: "index")
    }
	
	func ready(){
		print("ready")
	}
	
	func start(){
		let dictionary:[String : Any] = Logo.getInput()
		if let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
			let theJSONText = String(data: theJSONData, encoding: .ascii)
			codeRunner.run(fnName: "run", arg: theJSONText!)
			let when = DispatchTime.now() + 5
			DispatchQueue.main.asyncAfter(deadline: when) {
				print("STOP")
				self.codeRunner.run(fnName: "stop")
			}
		}
	}
	
	func consume(data: [String:Any]) {
		print("consume")
		let type = data["type"] as? String
		if type == "command"{
			charList.consume(data:data)
		}
		else if(type == "error"){
			
		}
	}
	
	func makeCharacters() {
		charList.setup()
		charList.getChars().forEach { (char) in
			objectsLayer.addChild(char.getSpriteNode())
		}
	}
	
	func makeGround() {
		var tileSprite:SKSpriteNode
		for j in stride(from: SIZE - 1, through: 0, by: -1) {
			for i in stride(from: SIZE - 1, through: 0, by: -1) {
				tileSprite = SKSpriteNode(imageNamed: "iso_ground.png")
				tileSprite.anchorPoint = CGPoint(x:0, y:0)
				Projections.posTile(tileSprite: tileSprite, cartPos: CGPoint(x:CGFloat(i), y:CGFloat(j)))
				groundLayer.addChild(tileSprite)
			}
		}
	}
	
	func sortDepth() {
		Projections.sortDepth(nodes: objectsLayer.children, min:groundLayer.children.count);
	}
	
	func updatePos(currentTime:TimeInterval){
		charList.updateAtTime(currentTime:currentTime)
	}
	
	override func update(_ currentTime: TimeInterval) {
		nthFrameCount += 1
		updatePos(currentTime:currentTime)
		if (nthFrameCount % nthFrame == 0) {
			nthFrameCount = 0
			sortDepth()
		}
		if(nthFrameCount == 200){
			//(objectsLayer.children[2] as! SKSpriteNode).texture = textures[5];
		}
	}
}
