//
//  Tile.swift
//  IsoGame
//
//  Created by John on 30/10/2017.
//  Copyright © 2017 Big Sprite Games. All rights reserved.
//

import Foundation

enum Tile: Int {
	
	case ground, object
	
	var description:String {
		switch self {
		case .ground:return "Ground"
		case .object:return "Object"
		}
	}
}
