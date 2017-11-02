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
	static func point2DToIso(_ p:CGPoint) -> CGPoint {
		var point = p * CGPoint(x:1, y:-1)
		point = CGPoint(x:(point.x - point.y), y: ((point.x + point.y) / 2))
		point = point * CGPoint(x:1, y:-1)
		return point
	}
	static func pointIsoTo2D(_ p:CGPoint) -> CGPoint {
		var point = p * CGPoint(x:1, y:-1)
		point = CGPoint(x:((2 * point.y + point.x) / 2), y: ((2 * point.y - point.x) / 2))
		point = point * CGPoint(x:1, y:-1)
		return point
	}
	static func sortDepth(nodes:[SKNode]){
		func isInFront(n0:SKNode, n1:SKNode) -> Bool{
			let p0 = Projections.pointIsoTo2D(n0.position)
			let p1 = Projections.pointIsoTo2D(n1.position)
			return (p0.x - p0.y < p1.x - p1.y);
		}
		let sortedNodes = nodes.sorted(by: isInFront)
		for i in 0..<nodes.count {
			(sortedNodes[i]).zPosition = CGFloat(i)
		}
	}
}
