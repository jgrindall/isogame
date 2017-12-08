
import UIKit
import SpriteKit

class GameScene: SKScene, PCodeConsumer  {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var chars : [PCharacter]
	var viewIso:SKSpriteNode
    var groundLayer:SKNode
    var objectsLayer:SKNode
    
    let nthFrame = 6
    var nthFrameCount = 0
	var floorHeight:CGFloat = 0.25
	var codeRunner:PCodeRunner
	var SIZE = 6
	var data:[[Float]] = [[2, 2, 1], [4, 4, 12]]
	
    override init(size: CGSize) {
		chars = [Character]()
		viewIso = SKSpriteNode()
        groundLayer = SKNode()
        objectsLayer = SKNode()
		codeRunner = CodeRunner()
		super.init(size: size)
	}
	
    override func didMove(to view: SKView) {
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
		let dictionary:[String : Any] = Logo.getInput()
		if let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
			let theJSONText = String(data: theJSONData, encoding: .ascii)
			codeRunner.run(fnName: "run", arg: theJSONText!)
		}
	}
	
	func consume(jsonString: String) {
		if let data:[String:Any] = jsonString.parseJSONString {
			let type = data["type"] as? String
			if type == "command"{
				chars[0].addAnimation(data: data)
			}
		}
	}
	
	func makeCharacters() {
		var tileSprite:SKSpriteNode
		for a in data{
			tileSprite = SpriteFactory.getSprite(name: "out" + String(Int(a[2])) + ".png")
			objectsLayer.addChild(tileSprite)
			chars.append(Character(spriteNode: tileSprite, x: 2, y: 2))
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
		chars.forEach { (char) in
			char.updateAtTime(currentTime:currentTime)
			Projections.posChar(char: char)
		}
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
