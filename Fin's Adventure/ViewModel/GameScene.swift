
//
//  GameScene.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 03/08/1445 AH.
//

import Foundation
import GameplayKit
import AVFoundation
import SwiftUI

class GameScene: SKScene, ObservableObject, SKPhysicsContactDelegate {
    
    let playerNode = SKSpriteNode(imageNamed: "fish1")
    var isTouchingScreen = false
    var enemyTimer = Timer()
    var scoreTimer = Timer()
    @Published var countdown = 60
    @Published var isGameOver = false
    @Published var score = 10
    
    
    
    //Scene Setup
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        setupScene()
        setupTimers()
        setupPlayer()
        SoundManager.shared.setupBackgroundMusic(soundName: "BGM", withExtension: "mp3")
    }
    
    //Touch Handling
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNodes = nodes(at: location)
        
        for node in touchedNodes {
            if node.name == "startBut" || node.name == "resetBut" {
                SoundManager.shared.playSoundEffect(soundName: "ButtonSound", withExtension: "mp3")
                node.name == "startBut" ? resetGame() : restartGame()
                return
            }
        }
        
        if !isGameOver {
            // Play the jump sound every time the screen is tapped
            SoundManager.shared.playSoundEffect(soundName: "jump", withExtension: "mp3")
            isTouchingScreen = true
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouchingScreen = false
    }
    
    //Game Loop
    override func update(_ currentTime: TimeInterval) {
        handlePlayerMovement()
        if !self.frame.contains(playerNode.position) {
            print("Player is off-screen")
        }
    }
    
    //Collision Handling
    func didBegin(_ contact: SKPhysicsContact) {
        guard let nodeA = contact.bodyA.node, let nodeB = contact.bodyB.node else { return }
        if nodeA == playerNode || nodeB == playerNode {
            playerCollided(with: nodeA == playerNode ? nodeB : nodeA)
        }
    }
    
    private func playerCollided(with node: SKNode) {
        if node.name == "badItem" || node.name == "goodItem" {
            node.name == "badItem" ? handleBadCollision() : handleGoodCollision()
            node.removeFromParent()
        }
    }
    
    private func handleBadCollision() {
        score -= 2
        if score <= 0 {
            endGame()
        }
        SoundManager.shared.playSoundEffect(soundName: "bad", withExtension: "mp3")
    }
    
    private func handleGoodCollision() {
        score += 1
        if score > 10 {
            score = 10
        }
        SoundManager.shared.playSoundEffect(soundName: "good", withExtension: "mp3")
    }
}
