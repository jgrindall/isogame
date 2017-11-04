//
//  TextureLoader.swift
//  IsoGame
//
//  Created by John on 30/10/2017.
//  Copyright © 2017 Big Sprite Games. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

func + (left: CGPoint, right: CGPoint) -> CGPoint {
	return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func - (left: CGPoint, right: CGPoint) -> CGPoint {
	return CGPoint(x: left.x - right.x, y: left.y - right.y)
}

func * (point0: CGPoint, point1: CGPoint) -> CGPoint {
	return CGPoint(x: point0.x * point1.x, y: point0.y * point1.y)
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
	return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func * (scalar: CGFloat, point: CGPoint) -> CGPoint {
	return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

func / (point: CGPoint, scalar: CGPoint) -> CGPoint {
	return CGPoint(x: point.x / scalar.x, y: point.y / scalar.y)
}

func distance(_ p1:CGPoint, p2:CGPoint) -> CGFloat {
	return CGFloat(hypotf(Float(p1.x) - Float(p2.x), Float(p1.y) - Float(p2.y)))
}

func round(_ point:CGPoint) -> CGPoint {
	return CGPoint(x: round(point.x), y: round(point.y))
}

func floor(_ point:CGPoint) -> CGPoint {
	return CGPoint(x: floor(point.x), y: floor(point.y))
}

func ceil(_ point:CGPoint) -> CGPoint {
	return CGPoint(x: ceil(point.x), y: ceil(point.y))
}

class Projections {
	
	static private var _tileSize:CGFloat = 64.0
	static private var _size:CGFloat = 6.0
	
	static func setup(tileSize:CGFloat, size:CGFloat){
		_tileSize = tileSize
		_size = size
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
			return (p0.x - p0.y < p1.x - p1.y);
		}
		let sortedNodes = nodes.sorted(by: isInFront)
		for i in 0..<nodes.count {
			(sortedNodes[i]).zPosition = CGFloat(min + 1 + i)
		}
	}
}
