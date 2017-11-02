//
//  GameViewController.swift
//  IsoGame
//
//  Created by Dave Longbottom on 16/01/2015.
//  Copyright (c) 2015 Big Sprite Games. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
	
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	
	var textures : [SKTexture]
	var viewIso:SKSpriteNode
    var groundLayer:SKNode
    var objectsLayer:SKNode
    let tileSize = (width:32.0, height:32.0)
    let nthFrame = 6
    var nthFrameCount = 0
	var SIZE = 6
	var data:[[Int]] = [[2, 2, 3], [1, 0, 0], [4, 4, 1], [3, 0, 2]]
	
    override init(size: CGSize) {
		textures = []
		viewIso = SKSpriteNode()
        groundLayer = SKNode()
        objectsLayer = SKNode()
		super.init(size: size)
		self.anchorPoint = CGPoint(x:0.5, y:0.5)
    }
	
    override func didMove(to view: SKView) {
		textures = TextureLoader.load(imgName:"max", jsonName:"max")
		print(textures)
		viewIso.position = CGPoint(x:0, y:0)
        viewIso.addChild(groundLayer)
        viewIso.addChild(objectsLayer)
        addChild(viewIso)
		makeGround();
		makeCharacter();
		makeCharacters();
    }
	
	func posGround(sprite:SKSpriteNode, position:CGPoint) {
		sprite.position = Projections.point2DToIso(position)
	}
	
	func makeCharacter() {
		var point:CGPoint
		var tileSprite:SKSpriteNode
		point = getXYPos(x: 2.0, y: 2.0)
		tileSprite = SKSpriteNode(texture: textures[0])
		//tileSprite.anchorPoint = CGPoint(x:0, y:0)
		posGround(sprite:tileSprite, position:point);
		objectsLayer.addChild(tileSprite)
	}
	
	func makeCharacters() {
		var point:CGPoint
		var tileSprite:SKSpriteNode
		for a in data{
			print(a);
			point = getXYPos(x: Double(a[0]), y: Double(a[1]))
			tileSprite = SKSpriteNode(texture: textures[a[2]])
			//tileSprite.anchorPoint = CGPoint(x:0, y:0)
			posGround(sprite:tileSprite, position:point);
			objectsLayer.addChild(tileSprite)
		}
	}
	
	func getXYPos(x:Double, y:Double) -> CGPoint {
		return CGPoint(x: x, y: y) * CGPoint(x:tileSize.width, y:tileSize.height)
	}
	
	func makeGround() {
		var point:CGPoint
		var tileSprite:SKSpriteNode
		for i in 0..<SIZE {
			for j in 0..<SIZE {
				point = getXYPos(x: Double(j), y: Double(i))
				tileSprite = SKSpriteNode(imageNamed: "iso_ground.png")
				tileSprite.anchorPoint = CGPoint(x:0, y:0)
				posGround(sprite:tileSprite, position:point)
				groundLayer.addChild(tileSprite)
			}
		}
	}
	
	func sortDepth() {
		Projections.sortDepth(nodes: objectsLayer.children);
	}
	
	override func update(_ currentTime: TimeInterval) {
		nthFrameCount += 1
		if (nthFrameCount == nthFrame) {
			nthFrameCount = 0
			sortDepth()
		}
	}
}
