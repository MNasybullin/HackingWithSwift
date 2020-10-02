//
//  Target.swift
//  Shooting_range
//
//  Created by Stomach Diego on 10/2/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit
import SpriteKit

class Target: SKNode {
    var target: SKSpriteNode!
    var stick: SKSpriteNode!
    
    func create() {
        let targetSprite = Int.random(in: 0...3)
        let stickSprite = Int.random(in: 0...2)
        
        target = SKSpriteNode(imageNamed: "target\(targetSprite)")
        stick = SKSpriteNode(imageNamed: "stick\(stickSprite)")
        
        target.name = "target"
        target.position.y += 116
        addChild(target)
        addChild(stick)
    }
}
