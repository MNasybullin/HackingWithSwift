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
    var gameTimer: Timer?
    var gameCount = 30 {
        didSet {
            if gameCount == 0 {
                gameTimer?.invalidate()
                isGameOver = true
                gameOver()
            }
        }
    }
    var shots: SKSpriteNode!
    var ammunition = 3 {
        didSet {
            let imageName: String!
            switch ammunition {
            case 1:
                imageName = "shots1"
            case 2:
                imageName = "shots2"
            case 3:
                imageName = "shots3"
            default:
                imageName = "shots0"
            }
            shots.removeFromParent()
            shots = SKSpriteNode(imageNamed: imageName)
            shots.name = "shots"
            shots.position = CGPoint(x:170, y: 30)
            shots.zPosition = 11
            addChild(shots)
        }
    }
    
    override func didMove(to view: SKView) {
        
        createBackground()
        createWater()
        createHUD()
        gameTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(gameLoop), userInfo: nil, repeats: true)
    }
    
    @objc func gameLoop() {
        gameCount -= 1
        let count = Int.random(in: 1...4)
        var i = 0
        while i < count {
            startGame()
            i += 1
        }
    }
    
    func gameOver() {
        let gameOver = SKSpriteNode(imageNamed: "gameOver")
        gameOver.position = CGPoint(x: 400, y: 300)
        gameOver.zPosition = 100
        
        let finalScore = SKLabelNode(fontNamed: "Chalkduster")
        finalScore.text = "Final score: \(score)"
        finalScore.position = CGPoint(x: 400, y: 150)
        finalScore.zPosition = 100
        finalScore.fontSize = 48
        
        addChild(gameOver)
        addChild(finalScore)
        
        run(SKAction.playSoundFileNamed("gameOverSound.mp3", waitForCompletion: false))
    }
    
    func startGame() {
        if isGameOver == true { return }
        
        let target = Target()
        target.create()
        let levelLine = Int.random(in: 0...2)
        switch levelLine {
        case 0:
            target.movingRight = true
            target.position.x = 0
            target.position.y = 220
            target.zPosition = 1
        case 1:
            target.position.x = 800
            target.position.y = 140
            target.zPosition = 3
        default:
            target.movingRight = true
            target.position.x = 0
            target.position.y = 70
            target.zPosition = 5
        }
        let duration = Double.random(in: 4...8)
        if target.movingRight == true {
            target.run(SKAction.moveBy(x: 1000, y: 0, duration: duration))
        } else {
            target.xScale = -target.xScale
            target.run(SKAction.moveBy(x: -1000, y: 0, duration: duration))
        }
        addChild(target)
    }
    
    override func update(_ currentTime: TimeInterval) {
        for node in children {
            if node.position.x < 0 || node.position.x > 800 {
                node.removeFromParent()
            }
        }
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
        
        shots = SKSpriteNode(imageNamed: "shots3")
        shots.name = "shots"
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
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let tappedNodes = nodes(at: location)
        ammunition -= 1
        for node in tappedNodes {
            if node.name == "shots" {
                ammunition = 3
                run(SKAction.playSoundFileNamed("reload.mp3", waitForCompletion: false))
                return
            }
            if node.name == "target" && ammunition >= 0 {
                let target = node.parent as! Target
                target.hit()
                score += 5
            }
        }
        if ammunition >= 0 {
            run(SKAction.playSoundFileNamed("shot.mp3", waitForCompletion: false))
        } else {
            run(SKAction.playSoundFileNamed("empty.mp3", waitForCompletion: false))
        }
    }
    
}
