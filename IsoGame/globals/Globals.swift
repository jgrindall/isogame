//
//  GameViewController.swift
//  IsoGame
//
//  Created by Dave Longbottom on 16/01/2015.
//  Copyright (c) 2015 Big Sprite Games. All rights reserved.
//

import Foundation
import UIKit
import SpriteKit

func CGPointFromArray (a:[CGFloat]) -> CGPoint{
	return CGPoint(x: a[0], y: a[1])
}

func CGPointFromArray (a:[Int]) -> CGPoint{
	return CGPoint(x: CGFloat(a[0]), y: CGFloat(a[1]))
}

func CGPointFromArray (a:[Float]) -> CGPoint{
	return CGPoint(x: CGFloat(a[0]), y: CGFloat(a[1]))
}

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

