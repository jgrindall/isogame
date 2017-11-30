

import Foundation
import UIKit
import SpriteKit

class Projections {
	
	static private var _tileSize:CGFloat = 64.0
	static private var _size:CGFloat = 6.0
	static private var floorHeight:CGFloat = 0.25
	
	static func setup(){

	}
	static func cartToIso(p:CGPoint) -> CGPoint{
		let xDir:CGPoint = CGPoint(x:_tileSize/2.0, y:_tileSize/4.0)
		let yDir:CGPoint = CGPoint(x:-1.0*_tileSize/2.0, y:_tileSize/4.0)
		let bottom:CGPoint = CGPoint(x:0, y: -1.0*CGFloat(_tileSize*_size)/4.0)
		return bottom + p.x*xDir + p.y*yDir
	}
	static func isoToCart(p:CGPoint) -> CGPoint{
		let alpha = _tileSize*_size / 4.0
		return CGPoint(x:(p.x + 2.0*p.y + 2*alpha)/_tileSize, y:(p.x - 2.0*p.y - 2*alpha)/(-1.0*_tileSize))
	}
	static func sortDepth(nodes:[SKNode], min:Int){
		func isInFront(n0:SKNode, n1:SKNode) -> Bool{
			let p0 = Projections.isoToCart(p: n0.position)
			let p1 = Projections.isoToCart(p: n1.position)
			let parallel0 = p0.x + p0.y
			let parallel1 = p1.x + p1.y
			return (parallel0 < parallel1)
		}
		let sortedNodes = nodes.sorted(by: isInFront)
		for i in 0..<nodes.count {
			(sortedNodes[i]).zPosition = CGFloat(min + 1 + i)
		}
	}
	static func getPosForTile(cartPos:CGPoint, w:Float, h:Float) -> CGPoint{
		let tileSizeFloat = CGFloat(_tileSize);
		let origin:CGPoint = CGPoint(x:w!/2, y:h!/2)
		var iso:CGPoint = Projections.cartToIso(p:cartPos)
		iso = iso + origin
		iso = iso + CGPoint(x: -tileSizeFloat/2.0, y: -tileSizeFloat*floorHeight)
		return iso
	}
	
	static func posTile(tileSprite:SKSpriteNode, cartPos:CGPoint, w:Float, h:Float){
		tileSprite.position = getPosForTile(cartPos: cartPos, w:w, h:h)
	}
}
