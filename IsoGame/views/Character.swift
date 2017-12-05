
import UIKit
import SpriteKit

class Character  {
	
	private var _animations:[Animation]
	private var _spriteNode:SKSpriteNode
	private var _currentAnimIndex:Int
	private var _cartPos:CGPoint
	private var _rot:Float
	private let _TIME:TimeInterval = 5
	private var _startTime:TimeInterval = 0
	
	init(spriteNode: SKSpriteNode, x:Float, y:Float) {
		_spriteNode = spriteNode
		_animations = Array()
		_currentAnimIndex = -1
		_cartPos = CGPoint(x: CGFloat(x), y: CGFloat(y))
		_rot = 0.0
	}
	
	func getSprite()->SKSpriteNode{
		return _spriteNode
	}
	
	func getCartPos()->CGPoint{
		return _cartPos
	}
	
	func setCartPos(p:CGPoint){
		print(p)
		_cartPos = p
	}
	
	func nextAnim(currentTime:TimeInterval){
		_currentAnimIndex = _currentAnimIndex + 1
		_startTime = currentTime
		if let anim = getAnimation() {
			anim.setTarget(target:self)
		}
	}
	
	func addAnimation(data:[String:Any]){
		_animations.append(AnimationFactory.make(data:data))
	}
	
	func getAnimation() -> Animation?{
		if(_currentAnimIndex >= 0 && _currentAnimIndex < _animations.count){
			return _animations[_currentAnimIndex]
		}
		return nil
	}
	
	func updatePos(currentTime:TimeInterval){
		if(currentTime >= _startTime + _TIME || _currentAnimIndex == -1){
			nextAnim(currentTime: currentTime)
		}
		if let anim = getAnimation() {
			anim.updateTarget(t: Float((currentTime - _startTime)/_TIME))
		}
	}
	
}
