//
//  setupScene.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 01/08/1445 AH.
//

import SpriteKit
import GameplayKit

extension GameScene {
    
    // Sets up the initial state of the scene
    func setupScene() {
        self.size = CGSize(width: 300, height: 100)
        scene?.scaleMode = .fill
        anchorPoint = CGPoint.zero
        physicsWorld.gravity = CGVector(dx: 0, dy: -2)
        physicsWorld.contactDelegate = self
        
        setupBackground()
    }
    
    // Establishes the background elements for the scene
    func setupBackground() {
        moveBackground(image: "Backg", y: 0, z: -5, duration: 10, needPhysics: false, size: self.size)
        moveBackground(image: "land", y: 0, z: -2, duration: 5, needPhysics: true, size: CGSize(width: self.size.width, height: 30))
    }
    
    // Creates and animates the background nodes
    func moveBackground(image: String, y: CGFloat, z: CGFloat, duration: TimeInterval, needPhysics: Bool, size: CGSize) {
        for i in 0...1 {
            let node = SKSpriteNode(imageNamed: image)
            node.anchorPoint = CGPoint.zero
            node.position = CGPoint(x: size.width * CGFloat(i), y: y)
            node.size = size
            node.zPosition = z
            
            if needPhysics {
                setupPhysicsForBackground(node: node)
            }
            
            let moveLeft = SKAction.moveBy(x: -node.size.width, y: 0, duration: duration)
            let resetPosition = SKAction.moveBy(x: node.size.width, y: 0, duration: 0)
            let moveSequence = SKAction.sequence([moveLeft, resetPosition])
            
            node.run(SKAction.repeatForever(moveSequence))
            addChild(node)
        }
    }
    
    // Adds physics properties to the background nodes
    private func setupPhysicsForBackground(node: SKSpriteNode) {
        node.physicsBody = SKPhysicsBody(rectangleOf: node.size)
        node.physicsBody?.isDynamic = false
        node.physicsBody?.contactTestBitMask = 1
        node.name = "enemy"
    }
    
    // Initializes the timers used in the scene
    func setupTimers() {
        enemyTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(spawnEnemy), userInfo: nil, repeats: true)
        scoreTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCountdown), userInfo: nil, repeats: true)
    }
    
    // Updates the game countdown and ends the game if time is up
    @objc func updateCountdown() {
        countdown -= 1
        if countdown <= 0 {
            endGame()
        }
    }
}
