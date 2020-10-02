//
//  GameScene.swift
//  Shooting_range
//
//  Created by Stomach Diego on 10/2/20.
//  Copyright © 2020 Mansur Nasybullin. All rights reserved.
//

import UIKit
import SpriteKit

class GameScene: SKScene {
    
    var isGameOver = false
    var scoreLabel: SKLabelNode!
    var score = 0 {
        didSet {
            scoreLabel.text = "Score: \(score)"
        }
    }
    
    override func didMove(to view: SKView) {
        
        createBackground()
        createWater()
        createHUD()
       
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "wood-background")
        background.position = CGPoint(x: 400, y: 300)
        background.blendMode = .replace
        background.zPosition = -1
        addChild(background)
               
        let grassTrees = SKSpriteNode(imageNamed: "grass-trees")
        grassTrees.position = CGPoint(x:400, y: 330)
        grassTrees.zPosition = 0
        addChild(grassTrees)
    }
    
    func createWater() {
        func animate(_ node: SKNode, distance: CGFloat, duration: TimeInterval) {
            let movementUp = SKAction.moveBy(x: 0, y: distance, duration: duration)
            let movementDown = movementUp.reversed()
            let sequence = SKAction.sequence([movementUp, movementDown])
            let repeatForever = SKAction.repeatForever(sequence)
            node.run(repeatForever)
        }

        let waterBackground = SKSpriteNode(imageNamed: "water-bg")
        waterBackground.position = CGPoint(x: 400, y: 200)
        waterBackground.zPosition = 2
        addChild(waterBackground)


        let waterForeground = SKSpriteNode(imageNamed: "water-fg")
        waterForeground.position = CGPoint(x: 400, y: 120)
        waterForeground.zPosition = 4
        addChild(waterForeground)

        animate(waterBackground, distance: 8, duration: 1.3)
        animate(waterForeground, distance: 12, duration: 1)
    }
    
    func createHUD() {
        let curtains = SKSpriteNode(imageNamed: "curtains")
        curtains.position = CGPoint(x:400, y: 300)
        curtains.zPosition = 10
        addChild(curtains)
        
        let shots = SKSpriteNode(imageNamed: "shots3")
        shots.position = CGPoint(x:170, y: 30)
        shots.zPosition = 11
        addChild(shots)
        
        scoreLabel = SKLabelNode(fontNamed: "Chalkduster")
        scoreLabel.position = CGPoint(x:550, y:16)
        scoreLabel.horizontalAlignmentMode = .left
        scoreLabel.zPosition = 11
        addChild(scoreLabel)
        
        score = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
}
