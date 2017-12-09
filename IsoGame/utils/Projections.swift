

import Foundation
import UIKit
import SpriteKit

class Projections {
	
	static private var _tileSize:CGFloat = 64.0
	static private var _size:CGFloat = 6.0
	static private var _floorHeight:CGFloat = 0.25
	static private var _width:CGFloat = 1024
	static private var _height:CGFloat = 768
	
	static func setup(){

	}
	static func setupSize(w:CGFloat, h:CGFloat){
		_width = w
		_height = h
	}
	static private func _cartToIso(p:CGPoint) -> CGPoint{
		let xDir:CGPoint = CGPoint(x:_tileSize/2.0, y:_tileSize/4.0)
		let yDir:CGPoint = CGPoint(x:-1.0*_tileSize/2.0, y:_tileSize/4.0)
		let bottom:CGPoint = CGPoint(x:0, y: -1.0*CGFloat(_tileSize*_size)/4.0)
		return bottom + p.x*xDir + p.y*yDir
	}
	static private func _isoToCart(p:CGPoint) -> CGPoint{
		let alpha = _tileSize*_size / 4.0
		return CGPoint(x:(p.x + 2.0*p.y + 2*alpha)/_tileSize, y:(p.x - 2.0*p.y - 2*alpha)/(-1.0*_tileSize))
	}
	static func sortDepth(nodes:[SKNode], min:Int){
		func isInFront(n0:SKNode, n1:SKNode) -> Bool{
			let p0 = Projections._isoToCart(p: n0.position)
			let p1 = Projections._isoToCart(p: n1.position)
			let parallel0 = p0.x + p0.y
			let parallel1 = p1.x + p1.y
			return (parallel0 < parallel1)
		}
		let sortedNodes = nodes.sorted(by: isInFront)
		for i in 0..<nodes.count {
			(sortedNodes[i]).zPosition = CGFloat(min + 1 + i)
		}
	}
	static private func _getPosForTile(cartPos:CGPoint) -> CGPoint{
		let tileSizeFloat = CGFloat(_tileSize);
		let origin:CGPoint = CGPoint(x:self._width/2, y:self._height/2)
		var iso:CGPoint = Projections._cartToIso(p:cartPos)
		iso = iso + origin
		iso = iso + CGPoint(x: -tileSizeFloat/2.0, y: -tileSizeFloat*_floorHeight)
		return iso
	}
	
	static func posChar(char:PCharacter){
		Projections.posTile(tileSprite: char.getSpriteNode(), cartPos: char.getCartPos())
	}
	
	static func posTile(tileSprite:SKSpriteNode, cartPos:CGPoint){
		tileSprite.position = _getPosForTile(cartPos: cartPos)
	}
}
