//
//  Texture.swift
//  IsoGame
//
//  Created by Dave Longbottom on 24/02/2015.
//  Copyright (c) 2015 Big Sprite Games. All rights reserved.
//

import Foundation
import SpriteKit

func textureImage(_ tile:Tile, direction:Direction, action:Action) -> String {
    
    switch tile {
    case .droid:
        switch action {
        case .idle:
            switch direction {
            case .n:return "droid_n"
            case .ne:return "droid_ne"
            case .e:return "droid_e"
            case .se:return "droid_se"
            case .s:return "droid_s"
            case .sw:return "droid_sw"
            case .w:return "droid_w"
            case .nw:return "droid_nw"
            }
        case .move:
            switch direction {
            case .n:return "droid_n"
            case .ne:return "droid_ne"
            case .e:return "droid_e"
            case .se:return "droid_se"
            case .s:return "droid_s"
            case .sw:return "droid_sw"
            case .w:return "droid_w"
            case .nw:return "droid_nw"
            }
        }
    case .ground:
        return "ground"
    case .wall:
        switch direction {
        case .n:return "wall_n"
        case .ne:return "wall_ne"
        case .e:return "wall_e"
        case .se:return "wall_se"
        case .s:return "wall_s"
        case .sw:return "wall_sw"
        case .w:return "wall_w"
        case .nw:return "wall_nw"
        }
    }
    
}
protocol TextureObject {
    static var sharedInstance: TextureDroid {get}
    var texturesIso:[[SKTexture]?] {get}
    var textures2D:[[SKTexture]?] {get}
}
private let textureDroid = TextureDroid()

class TextureDroid: TextureObject  {
    
    class var sharedInstance: TextureDroid {
        return textureDroid
    }
    
    var texturesIso:[[SKTexture]?]
    var textures2D:[[SKTexture]?]
    
    init() {
        
        texturesIso = [[SKTexture]?](repeating: nil, count: 2)
        textures2D = [[SKTexture]?](repeating: nil, count: 2)
        
        //Idle
        texturesIso[Action.idle.rawValue] = [
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.n, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.ne, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.e, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.se, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.s, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.sw, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.w, action: Action.idle)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.nw, action: Action.idle)),
        ]
        
        //Move
        texturesIso[Action.move.rawValue] = [
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.n, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.nw, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.e, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.se, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.s, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.sw, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.w, action: Action.move)),
            SKTexture(imageNamed: "iso_3d_"+textureImage(Tile.droid, direction: Direction.nw, action: Action.move)),
        ]
        
        //Idle
        textures2D[Action.idle.rawValue] = [
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.n, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.ne, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.e, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.se, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.s, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.sw, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.w, action: Action.idle)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.nw, action: Action.idle)),
        ]
        
        //Move
        textures2D[Action.move.rawValue] = [
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.n, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.ne, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.e, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.se, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.s, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.sw, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.w, action: Action.move)),
            SKTexture(imageNamed: textureImage(Tile.droid, direction: Direction.nw, action: Action.move)),
        ]
        
    }
    
}
