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

func * (point: CGPoint, scalar: CGPoint) -> CGPoint {
	return CGPoint(x: point.x * scalar.x, y: point.y * scalar.y)
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
	static func cartToIso(_ p:CGPoint) -> CGPoint {
		return CGPoint(x:(p.x - p.y), y: ((p.x + p.y) / 2))
	}
	static func isoToCart(_ p:CGPoint) -> CGPoint {
		return CGPoint(x:((2 * p.y + p.x) / 2), y: ((2 * p.y - p.x) / 2))
	}
	static func sortDepth(nodes:[SKNode]){
		func isInFront(n0:SKNode, n1:SKNode) -> Bool{
			let p0 = Projections.isoToCart(n0.position)
			let p1 = Projections.isoToCart(n1.position)
			return (p0.x - p0.y < p1.x - p1.y);
		}
		let sortedNodes = nodes.sorted(by: isInFront)
		for i in 0..<nodes.count {
			(sortedNodes[i]).zPosition = 100 + CGFloat(i)
		}
	}
}
