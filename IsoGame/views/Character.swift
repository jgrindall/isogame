
import UIKit
import SpriteKit

class AnimationHandler : PAnimationHandler{
	private var _animationQueue:Queue<Animation>
	private var _currentAnim:Animation?
	private var _char:PCharacter
	
	init(char: PCharacter) {
		_animationQueue = Queue<Animation>()
		_char = char
	}
	func updateAtTime(currentTime:TimeInterval){
		if (_currentAnim == nil && _animationQueue.getLength() >= 1){
			_setCurrent(anim:_animationQueue.peek()!, currentTime:currentTime)
		}
		else{
			_checkFinished(currentTime: currentTime)
		}
		if let anim = _currentAnim {
			anim.updateTargetAtTime(currentTime:currentTime)
		}
	}
	private func _setCurrent(anim:Animation, currentTime:TimeInterval){
		_currentAnim = anim
		_currentAnim?.setup(target: _char, startTime:currentTime)
	}
	
	private func _nextAnim(currentTime:TimeInterval){
		if(_animationQueue.getLength() >= 1){
			let anim:Animation = _animationQueue.peek()!
			anim.start()
			_setCurrent(anim:anim, currentTime:currentTime)
		}
		else{
			_currentAnim = nil
		}
	}
	
	func addAnimation(anim:Animation){
		_animationQueue.enqueue(anim)
	}
	
	private func _checkFinished(currentTime:TimeInterval){
		if let anim = _currentAnim{
			if(anim.isFinished(currentTime:currentTime)){
				_ = _animationQueue.dequeue()
				_nextAnim(currentTime: currentTime)
			}
		}
	}
}

class Character : PCharacter {
	
	private var _spriteNode:SKSpriteNode
	private var _cartPos:CGPoint
	private var _rot:Float
	private var _id:Int
	private var _characterAnimation:AnimationHandler! = nil
	
	init(id: Int, texture:Int, x:Float, y:Float, rot:Float) {
		_spriteNode = SpriteFactory.getSprite(name: "out" + String(texture) + ".png")
		_cartPos = CGPoint(x: CGFloat(x), y: CGFloat(y))
		_rot = rot
		_id = id
		_characterAnimation = AnimationHandler(char: self)
	}
	
	func getId()->Int{
		return _id
	}
	
	func getSpriteNode()->SKSpriteNode{
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
	
	func addAnimation(data:[String:Any]){
		let anim = AnimationFactory.make(data:data)
		_characterAnimation.addAnimation(anim: anim)
	}
	
	func updateAtTime(currentTime:TimeInterval){
		_characterAnimation.updateAtTime(currentTime:currentTime)
	}
	
}
