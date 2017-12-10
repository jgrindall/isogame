
import UIKit
import SpriteKit

class GameScene: SKScene  {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var charList : CharacterList
	var viewIso:SKSpriteNode
    var groundLayer:SKNode
    var objectsLayer:SKNode
    let nthFrame = 6
    var nthFrameCount = 0
	var SIZE = 6
	
    override init(size: CGSize) {
		charList = CharacterList()
		viewIso = SKSpriteNode()
        groundLayer = SKNode()
        objectsLayer = SKNode()
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
    }
	
	func makeCharacters() {
		charList.setup()
		charList.getChars().forEach { (char) in
			objectsLayer.addChild(char.getSpriteNode())
		}
	}
	
	func consume(data:[String:Any]){
		charList.consume(data: data)
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
