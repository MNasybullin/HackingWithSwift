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
    var isHit = false
    var isVisible = false
    var movingRight = false
    
    func create() {
        isVisible = true
        let targetSprite = Int.random(in: 0...3)
        let stickSprite = Int.random(in: 0...2)
        
        target = SKSpriteNode(imageNamed: "target\(targetSprite)")
        stick = SKSpriteNode(imageNamed: "stick\(stickSprite)")
        
        target.name = "target"
        target.position.y += 116
        
        addChild(target)
        addChild(stick)
    }
    
    func hit() {
        isHit = true
        
        let scale = SKAction.scale(by: 0.25, duration: 0.25)
        let hide = SKAction.moveBy(x: 0, y: -200, duration: 0.8)
        let notVisible = SKAction.run {
            [unowned self] in self.isVisible = false
        }
        target.run(SKAction.sequence([scale, hide, notVisible]))
        stick.run(SKAction.sequence([scale, hide, notVisible]))
    }
}
