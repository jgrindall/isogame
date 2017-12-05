
import UIKit
import SpriteKit

class Animation {
	var _target : Character? = nil
	init(data:[String:Any]){
		
	}
	func setTarget(target:Character){
		_target = target
	}
	func updateTarget(t:Float){
	
	}
}

class FdAnimation : Animation {
	var _endPos:CGPoint
	var _startPos:CGPoint
	override init(data:[String:Any]){
		_endPos = CGPoint.zero
		_startPos = CGPoint.zero
		super.init(data: data)
	}
	override func setTarget(target: Character) {
		super.setTarget(target: target)
		_endPos = target.getCartPos().clone() + CGPoint(x: 1, y: 0)
		_startPos = target.getCartPos().clone()
	}
	override func updateTarget(t:Float){
		_target?.setCartPos(p: _startPos.towards(p: _endPos, t: CGFloat(t)))
	}
}

class AnimationFactory {
	static func make(data:[String:Any]) -> Animation{
		return FdAnimation(data: data)
	}
}
