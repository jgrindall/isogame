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

class TextureLoader {
	
	static func load(imgName:String, jsonName:String) -> [String: SKTexture]{
		var textures = [String: SKTexture]()
		let imgPath = Bundle.main.path(forResource: imgName, ofType: "png")
		let jsonPath = Bundle.main.path(forResource: jsonName, ofType: "json")
		let sourceTexture = SKTexture(image: UIImage(contentsOfFile: imgPath!)!)
		do {
			let data = try Data(contentsOf: URL(fileURLWithPath: jsonPath!), options: .mappedIfSafe)
			let jsonResult = try JSONSerialization.jsonObject(with: data) as? [String: Any]
			let frames = jsonResult?["frames"] as? [[String: Any]]
			let meta = jsonResult?["meta"] as? [String: Any]
			let fullWidth = meta?["width"] as? Float
			let fullHeight = meta?["height"] as? Float
			var frameData:[String: Any]
			var name:String
			var x, y, w, h: Float
			var xScaled, yScaled, wScaled, hScaled: CGFloat
			var texture: SKTexture
			for frame in frames! {
				name = frame["filename"] as! String
				frameData = frame["frame"] as! [String: Any]
				x = (frameData["x"] as? Float)!
				if(x < 0){
					x = -1.0 * x
				}
				y = (frameData["y"] as? Float)!
				if(y < 0){
					y = -1.0 * y
				}
				w = (frameData["w"] as? Float)!
				h = (frameData["h"] as? Float)!
				xScaled = CGFloat(x/fullWidth!)
				yScaled = CGFloat(y/fullHeight!)
				wScaled = CGFloat(w/fullWidth!)
				hScaled = CGFloat(h/fullHeight!)
				texture = SKTexture(rect: CGRect(x: xScaled, y: yScaled, width: wScaled, height: hScaled), in: sourceTexture)
				print(name, xScaled, yScaled, wScaled, hScaled)
				textures[name] = texture
			}
		}
		catch {
			// handle error
		}
		return textures
	}
	
}
