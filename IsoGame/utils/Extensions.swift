//
//  Extensions.swift
//  IsoGame
//
//  Created by John on 04/11/2017.
//  Copyright © 2017 Big Sprite Games. All rights reserved.
//

import Foundation

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
