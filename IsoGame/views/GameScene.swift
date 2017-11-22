
import UIKit
import SpriteKit

class GameScene: SKScene, PCodeConsumer  {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var textures : [String: SKTexture]
	var codeRunner:PCodeRunner
	var viewIso:SKSpriteNode
    var groundLayer:SKNode
    var objectsLayer:SKNode
    let TILESIZE = 64
    let nthFrame = 6
    var nthFrameCount = 0
	var floorHeight:CGFloat = 0.25
	var SIZE = 6
	var data:[[Float]] = [[0, 0, 1], [4, 4, 12]]
	
    override init(size: CGSize) {
		textures = [String: SKTexture]()
		viewIso = SKSpriteNode()
        groundLayer = SKNode()
        objectsLayer = SKNode()
		codeRunner = CodeRunner(fileNames: ["index"])
		super.init(size: size)
	}
	
    override func didMove(to view: SKView) {
		TextureLoader.load(imgName:"max", jsonName:"max", textures:&textures)
		viewIso.position = CGPoint(x:0, y:0)
        viewIso.addChild(groundLayer)
        viewIso.addChild(objectsLayer)
        addChild(viewIso)
		Projections.setup(tileSize: CGFloat(TILESIZE), size: CGFloat(SIZE))
		makeGround()
		makeCharacters()
		setupJS()
    }
	
	func setupJS(){
		codeRunner.setConsumer(consumer: self);
		codeRunner.run(fnName: "check", arg: "a")
	}
	
	func consume(type: String, data: String) {
		//?
	}
	
	func getPosForTile(cartPos:CGPoint) -> CGPoint{
		let tileSizeFloat = CGFloat(TILESIZE);
		let origin:CGPoint = CGPoint(x:(self.view?.frame.width)!/2, y:(self.view?.frame.height)!/2)
		var iso:CGPoint = Projections.cartToIso(p:cartPos)
		iso = iso + origin
		iso = iso + CGPoint(x: -tileSizeFloat/2.0, y: -tileSizeFloat*floorHeight)
		return iso
	}
	
	func posTile(tileSprite:SKSpriteNode, cartPos:CGPoint){
		tileSprite.position = getPosForTile(cartPos: cartPos)
	}
	
	func makeTile(name:String)-> SKSpriteNode{
		let tileSprite = SKSpriteNode(texture: textures[name])
		tileSprite.anchorPoint = CGPoint(x:0, y:0)
		return tileSprite
	}
	
	func makeCharacters() {
		var tileSprite:SKSpriteNode
		for a in data{
			tileSprite = makeTile(name: "out" + String(Int(a[2])) + ".png")
			posTile(tileSprite: tileSprite, cartPos: CGPointFromArray(a: a))
			objectsLayer.addChild(tileSprite)
		}
	}
	
	func makeGround() {
		var tileSprite:SKSpriteNode
		for j in stride(from: SIZE - 1, through: 0, by: -1) {
			for i in stride(from: SIZE - 1, through: 0, by: -1) {
				tileSprite = SKSpriteNode(imageNamed: "iso_ground.png")
				tileSprite.anchorPoint = CGPoint(x:0, y:0)
				posTile(tileSprite: tileSprite, cartPos: CGPoint(x:CGFloat(i), y:CGFloat(j)))
				groundLayer.addChild(tileSprite)
			}
		}
	}
	
	func sortDepth() {
		Projections.sortDepth(nodes: objectsLayer.children, min:groundLayer.children.count);
	}
	
	func updatePos(){
		data[0][0] = data[0][0] + 0.0025
		posTile(tileSprite: objectsLayer.children[0] as! SKSpriteNode, cartPos: CGPointFromArray(a: data[0]))
	}
	
	override func update(_ currentTime: TimeInterval) {
		nthFrameCount += 1
		updatePos();
		if (nthFrameCount % nthFrame == 0) {
			sortDepth()
		}
		if(nthFrameCount == 200){
			//(objectsLayer.children[2] as! SKSpriteNode).texture = textures[5];
		}
	}
}
