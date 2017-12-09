
import UIKit
import SpriteKit

protocol PAnimationHandler {
	func updateAtTime(currentTime:TimeInterval)
	func addAnimation(anim:Animation)
}

protocol PAnimation{
	func setup(target:PCharacter, startTime:TimeInterval)
	func updateTargetAtTime(currentTime:TimeInterval)
	func isFinished(currentTime:TimeInterval) -> Bool
	func start()
}

protocol PCharacter {
	func getSpriteNode()->SKSpriteNode
	func getCartPos()->CGPoint
	func getRot()->Float
	func setCartPos(p:CGPoint)
	func setRot(r:Float)
	func addAnimation(data:[String:Any])
	func updateAtTime(currentTime:TimeInterval)
	func getId() -> Int
}
