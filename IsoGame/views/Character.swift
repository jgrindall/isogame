
import UIKit
import SpriteKit

class Character  {
	
	private var _animations:[Any?]
	private var _spriteNode:SKSpriteNode
	private var _currentAnim:Int
	private var _p:CGPoint
	
	init(spriteNode: SKSpriteNode, x:Float, y:Float) {
		_spriteNode = spriteNode
		_animations = []
		_currentAnim = 0
		_p = CGPoint(x: CGFloat(x), y: CGFloat(y))
	}
	
	func getSprite()->SKSpriteNode{
		return _spriteNode
	}
	
	func getCartPos()->CGPoint{
		return _p
	}
	
	func addAnimation(data:[String:Any]){
		_animations.append(data)
	}
	
	func updatePos(currentTime:TimeInterval){
		//_animations
	}
	
}
