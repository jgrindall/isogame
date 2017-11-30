

import Foundation
import UIKit
import SpriteKit

class SpriteFactory {
	
	static private var _textures:[String: SKTexture] = [String: SKTexture]()
	static private var _loaded:Bool = false
	
	static func load(){
		TextureLoader.load(imgName:"max", jsonName:"max", textures:&_textures)
		_loaded = true
	}
	
	static func getTexture(name:String)->SKTexture{
		if(!_loaded){
			SpriteFactory.load()
		}
		return _textures[name]!
	}
	
	static func getSprite(name:String) -> SKSpriteNode{
		let tileSprite = SKSpriteNode(texture: SpriteFactory.getTexture(name: name))
		tileSprite.anchorPoint = CGPoint(x:0, y:0)
		return tileSprite
		
	}
	
}
