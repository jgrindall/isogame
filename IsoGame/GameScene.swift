//
//  GameViewController.swift
//  IsoGame
//
//  Created by Dave Longbottom on 16/01/2015.
//  Copyright (c) 2015 Big Sprite Games. All rights reserved.
//

//https://mazebert.com/2013/04/18/isometric-depth-sorting/

import UIKit
import SpriteKit

class GameScene: SKScene {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var textures : [String: SKTexture]
	var viewIso:SKSpriteNode
    var groundLayer:SKNode
    var objectsLayer:SKNode
    let TILESIZE = 64
    let nthFrame = 6
    var nthFrameCount = 0
	var floorHeight:CGFloat = 0.25
	var SIZE = 6
	var data:[[Int]] = [[0, 0, 90]]
	
    override init(size: CGSize) {
		textures = [String: SKTexture]()
		viewIso = SKSpriteNode()
        groundLayer = SKNode()
        objectsLayer = SKNode()
		super.init(size: size)
	}
	
    override func didMove(to view: SKView) {
		textures = TextureLoader.load(imgName:"max", jsonName:"max")
		viewIso.position = CGPoint(x:0, y:0)
        viewIso.addChild(groundLayer)
        viewIso.addChild(objectsLayer)
        addChild(viewIso)
		Projections.setup(tileSize: CGFloat(TILESIZE), size: CGFloat(SIZE))
		makeGround()
		makeCharacters()
    }
	
	func makeCharacters() {
		var tileSprite:SKSpriteNode
		let tileSizeFloat = CGFloat(TILESIZE);
		let origin:CGPoint = CGPoint(x:(self.view?.frame.width)!/2, y:(self.view?.frame.height)!/2)
		for a in data{
			var iso:CGPoint = Projections.cartToIso(p:CGPoint(x:a[0], y:a[1]))
			iso = iso + origin
			let name:String = "out" + String(a[2]) + ".png"
			tileSprite = SKSpriteNode(texture: textures[name])
			tileSprite.anchorPoint = CGPoint(x:0, y:0)
			tileSprite.position = CGPoint(x:iso.x - tileSizeFloat/2.0, y:iso.y - tileSizeFloat*floorHeight)
			objectsLayer.addChild(tileSprite)
		}
	}
	
	func makeGround() {
		let tileSizeFloat = CGFloat(TILESIZE);
		let origin:CGPoint = CGPoint(x:(self.view?.frame.width)!/2, y:(self.view?.frame.height)!/2)
		var tileSprite:SKSpriteNode
		for j in stride(from: SIZE - 1, through: 0, by: -1) {
			for i in stride(from: SIZE - 1, through: 0, by: -1) {
				tileSprite = SKSpriteNode(imageNamed: "iso_ground.png")
				tileSprite.anchorPoint = CGPoint(x:0, y:0)
				var iso:CGPoint = Projections.cartToIso(p:CGPoint(x:CGFloat(i), y:CGFloat(j)))
				iso = iso + origin
				tileSprite.position = CGPoint(x:iso.x - tileSizeFloat/2.0, y:iso.y - tileSizeFloat*floorHeight)
				groundLayer.addChild(tileSprite)
			}
		}
	}
	
	func sortDepth() {
		Projections.sortDepth(nodes: objectsLayer.children, min:groundLayer.children.count);
	}
	
	override func update(_ currentTime: TimeInterval) {
		nthFrameCount += 1
		//objectsLayer.children[0].position.x += 0.1;
		//objectsLayer.children[1].position.y += 0.1;
		//objectsLayer.children[2].position.x += 0.05;
		//objectsLayer.children[2].position.y -= 0.1;
		if (nthFrameCount % nthFrame == 0) {
			sortDepth()
		}
		if(nthFrameCount == 200){
			//(objectsLayer.children[2] as! SKSpriteNode).texture = textures[5];
		}
	}
}
