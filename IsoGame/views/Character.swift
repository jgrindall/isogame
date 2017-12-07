
import UIKit
import SpriteKit

enum VendingMachineError: Error {
	case invalidSelection
}

class Character  {
	
	private var _animations:Queue<Animation>
	private var _spriteNode:SKSpriteNode
	private var _currentAnim:Animation?
	private var _cartPos:CGPoint
	private var _rot:Float
	
	init(spriteNode: SKSpriteNode, x:Float, y:Float) {
		_spriteNode = spriteNode
		_animations = Queue<Animation>()
		_cartPos = CGPoint(x: CGFloat(x), y: CGFloat(y))
		_rot = 0.0
	}
	
	func getSprite()->SKSpriteNode{
		return _spriteNode
	}
	
	func getCartPos()->CGPoint{
		return _cartPos
	}
	
	func getRot()->Float{
		return _rot
	}
	
	func setCartPos(p:CGPoint){
		_cartPos = p
	}
	
	func setRot(r:Float){
		_rot = r
		while(_rot > 360.0){
			_rot = _rot - 360.0
		}
		while(_rot < 0.0){
			_rot = _rot + 360.0
		}
		updateTexture()
	}
	
	private func updateTexture(){
		var i:Int
		if(_rot < 180.0){
			i = 1
		}
		else{
			i = 12
		}
		_spriteNode.texture = SpriteFactory.getTexture(name: "out" + String(i) + ".png")
	}
	
	func setCurrent(anim:Animation, currentTime:TimeInterval){
		_currentAnim = anim
		_currentAnim?.setup(target: self, startTime:currentTime)
	}
	
	func nextAnim(currentTime:TimeInterval){
		if(_animations.getLength() >= 2){
			_ = _animations.dequeue() // this is the current one
			setCurrent(anim:_animations.peek()!, currentTime:currentTime)
		}
	}
	
	func addAnimation(data:[String:Any]){
		_animations.enqueue(AnimationFactory.make(data:data))
	}
	
	func checkFinished(currentTime:TimeInterval){
		if let anim = _currentAnim{
			if(anim.isFinished(currentTime:currentTime)){
				nextAnim(currentTime: currentTime)
			}
		}
	}
	
	func updatePos(currentTime:TimeInterval){
		if (_currentAnim == nil && _animations.getLength() >= 1){
			setCurrent(anim:_animations.peek()!, currentTime:currentTime)
		}
		else{
			checkFinished(currentTime: currentTime)
		}
		if let anim = _currentAnim {
			anim.updateTargetAtTime(currentTime:currentTime)
		}
	}
	
}
