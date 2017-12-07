
import UIKit
import SpriteKit

private let _TIME:TimeInterval = 0.333

class Animation {
	var _target: Character? = nil
	var _startTime:TimeInterval = 0
	init(data:[String:Any]){
		
	}
	func setup(target:Character, startTime:TimeInterval){
		_target = target
		_startTime = startTime
	}
	func updateTargetAtTime(currentTime:TimeInterval){
	
	}
	func isFinished(currentTime:TimeInterval) -> Bool{
		return false
	}
}

class FdAnimation : Animation {
	var _endPos:CGPoint
	var _startPos:CGPoint
	var _completionTime:TimeInterval
	override init(data:[String:Any]){
		_endPos = CGPoint.zero
		_startPos = CGPoint.zero
		_completionTime = _TIME
		super.init(data: data)
	}
	override func setup(target: Character, startTime:TimeInterval) {
		super.setup(target: target, startTime:startTime)
		_startPos = target.getCartPos().clone()
		let d:Float = 0.5;
		let dx:Float = d*cos(target.getRot() * 3.14159265/180.0)
		let dy:Float = d*sin(target.getRot() * 3.14159265/180.0)
		_endPos = target.getCartPos().clone() + CGPoint(x: CGFloat(dx), y: CGFloat(dy))
	}
	override func updateTargetAtTime(currentTime:TimeInterval){
		let t:CGFloat = CGFloat((currentTime - _startTime)/_completionTime)
		_target?.setCartPos(p: _startPos.towards(p: _endPos, t: t))
	}
	override func isFinished(currentTime:TimeInterval) -> Bool{
		return (currentTime - _startTime > _completionTime)
	}
}

class RtAnimation : Animation {
	var _endRot:Float
	var _startRot:Float
	var _completionTime:TimeInterval
	override init(data:[String:Any]){
		_endRot = 0
		_startRot = 0
		_completionTime = _TIME
		super.init(data: data)
	}
	override func setup(target: Character, startTime:TimeInterval) {
		super.setup(target: target, startTime:startTime)
		_startRot = target.getRot()
		_endRot = target.getRot() + 20
	}
	override func updateTargetAtTime(currentTime:TimeInterval){
		let t:CGFloat = CGFloat((currentTime - _startTime)/_completionTime)
		_target?.setRot(r: _startRot.towards(p: _endRot, t: Float(t)))
	}
	override func isFinished(currentTime:TimeInterval) -> Bool{
		return (currentTime - _startTime > _completionTime)
	}
}

class AnimationFactory {
	static func make(data:[String:Any]) -> Animation{
		let name = data["name"] as? String
		if(name == "fd"){
			return FdAnimation(data: data)
		}
		else if(name == "rt"){
			return RtAnimation(data: data)
		}
		else{
			return FdAnimation(data: data)
		}
	}
}
