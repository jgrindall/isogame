
import UIKit
import SpriteKit

class Character  {
	
	private var _animations:[[String:Any]]
	private var _spriteNode:SKSpriteNode
	private var _currentAnimIndex:Int
	private var _cartPos:CGPoint
	private var _endPos:CGPoint
	private var _startPos:CGPoint
	private var _TIME:TimeInterval = 5
	private var _startTime:TimeInterval = 0
	
	init(spriteNode: SKSpriteNode, x:Float, y:Float) {
		_spriteNode = spriteNode
		_animations = Array()
		_currentAnimIndex = -1
		_cartPos = CGPoint(x: CGFloat(x), y: CGFloat(y))
		_endPos = _cartPos.clone()
		_startPos = _cartPos.clone()
	}
	
	func getSprite()->SKSpriteNode{
		return _spriteNode
	}
	
	func getCartPos()->CGPoint{
		return _cartPos
	}
	
	func nextAnim(currentTime:TimeInterval){
		_currentAnimIndex = _currentAnimIndex + 1
		_startTime = currentTime
		_endPos = _cartPos.clone() + CGPoint(x: 1, y: 0)
		_startPos = _cartPos.clone()
	}
	
	func addAnimation(data:[String:Any]){
		_animations.append(data)
	}
	
	func getAnimation() -> [String:Any]{
		return _animations[_currentAnimIndex];
	}
	
	func updatePos(currentTime:TimeInterval){
		if(currentTime >= _startTime + _TIME || _currentAnimIndex == -1){
			nextAnim(currentTime: currentTime)
		}
		let t:Float = Float((currentTime - _startTime)/_TIME)
		_cartPos = _startPos.towards(p: _endPos, t: CGFloat(t))
	}
	
}
