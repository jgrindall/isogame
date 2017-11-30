
import UIKit
import SpriteKit

class GameScene: SKScene, PCodeConsumer  {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var chars : [Character]
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
        addChild(viewIso)
		makeGround()
		makeCharacters()
		_ = codeRunner.setConsumer(consumer: self).load(fileName: "index")
    }
	
	func ready(){
		var STR =   "to test fd 1 end"
		//STR +=      "to setup-rabbit rt 90 activate-daemon daemon-rabbit-eat end"
		STR +=      "to setup-robot activate-daemon daemon-robot-walk end"
		//STR +=      "to setup-patch set-var age 0 activate-daemon daemon-patch-change end"
		STR +=      "to daemon-robot-walk fd 1 rt 1 end"
		//STR +=      "to daemon-rabbit-eat rt 10 end"
		//STR +=      "to daemon-patch-change set-var grass 5 end"
		let target0:[String:Any] = [
			"type":"robot",
			"id":1,
			"pos":[
				"x":0,
				"y":0
			],
			"angle":0
		]
		let target1:[String:Any] = [
			"type":"robot",
			"id":2,
			"pos":[
				"x":0,
				"y":0
			],
			"angle":0
		]
		let targets:[[String:Any]] = [
			target0,
			target1
		]
		let patches:[[String:Any]] = Array()
		let dictionary = [
			"targets": targets,
			"patches":patches,
			"logo": STR
		] as [String : Any]
		if let theJSONData = try? JSONSerialization.data(withJSONObject: dictionary, options: []) {
			let theJSONText = String(data: theJSONData, encoding: .ascii)
			codeRunner.run(fnName: "run", arg: theJSONText!)
		}
	}
	
	func consume(jsonString: String) {
		if let data:[String:Any] = jsonString.parseJSONString {
			if(String(describing: data["type"]) == "command"){
				if(String(describing:data["name"]) == "fd"){
					chars[0].addAnimation(data: data)
				}
				else if(String(describing:data["name"]) == "rt"){
					chars[0].addAnimation(data: data)
				}
			}
		}
	}
	
	func makeCharacters() {
		var tileSprite:SKSpriteNode
		for a in data{
			tileSprite = SpriteFactory.getSprite(name: "out" + String(Int(a[2])) + ".png")
			//posTile(tileSprite: tileSprite, cartPos: CGPointFromArray(a: a))
			objectsLayer.addChild(tileSprite)
			chars.append(Character(spriteNode: tileSprite))
		}
	}
	
	func makeGround() {
		var tileSprite:SKSpriteNode
		for j in stride(from: SIZE - 1, through: 0, by: -1) {
			for i in stride(from: SIZE - 1, through: 0, by: -1) {
				tileSprite = SKSpriteNode(imageNamed: "iso_ground.png")
				tileSprite.anchorPoint = CGPoint(x:0, y:0)
				//posTile(tileSprite: tileSprite, cartPos: CGPoint(x:CGFloat(i), y:CGFloat(j)))
				groundLayer.addChild(tileSprite)
			}
		}
	}
	
	func sortDepth() {
		Projections.sortDepth(nodes: objectsLayer.children, min:groundLayer.children.count);
	}
	
	func updatePos(currentTime:TimeInterval){
		chars.forEach { (char) in
			char.updatePos(currentTime:currentTime)
			Projections.posTile(char.getSprite(), char.getCartPos())
			
			//tileSprite.position = getPosForTile(cartPos: cartPos)
			
		}
		//data[0][0] = data[0][0] + 0.0025
		//posTile(tileSprite: objectsLayer.children[0] as! SKSpriteNode, cartPos: CGPointFromArray(a: data[0]))
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
