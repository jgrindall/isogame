//
//  Extensions.swift
//  IsoGame
//
//  Created by John on 04/11/2017.
//  Copyright © 2017 Big Sprite Games. All rights reserved.
//

import Foundation
import Foundation
import UIKit

extension String {
	var parseJSONString: [String:Any]? {
		let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
		do {
			let output = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers)
			return output as? [String:Any]
		}
		catch {
		}
		return nil
	}
}

extension CGPoint{
	public func clone() -> CGPoint {
		return CGPoint(x: x, y: y)
	}
	public func towards(p:CGPoint, t:CGFloat) -> CGPoint{
		return CGPoint(x: (1.0 - t)*x + t*p.x, y: (1.0 - t)*y + t*p.y)
	}
}
