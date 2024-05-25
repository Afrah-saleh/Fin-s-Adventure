//
//  GameOver.swift
//  Ocean Adventure
//
//  Created by Afrah Saleh on 11/07/1445 AH.
//

import SwiftUI
import SpriteKit
import Foundation
import GameplayKit

extension GameScene {
    
    func endGame() {
        invalidateTimers()
        isGameOver = true
        playerNode.physicsBody?.isDynamic = false
        playerNode.isHidden = true
        removeAllActions()
        SoundManager.shared.stopAllMusic()
        let soundToPlay = score <= 0 ? "loseMusic" : "winMusic"
        SoundManager.shared.playNonLoopingSound(soundName: soundToPlay, withExtension: "mp3")
        
        createEndView()
    }
    
    func createEndView() {
        let backgroundName = score <= 0 ? "loseBackground" : "winBackground"
        let gameOverBackground = createBackground(imageName: backgroundName, zPosition: 50)
        addChild(gameOverBackground)
        
        let endImageName = score <= 0 ? "lose" : "win"
        let endImage = createImage(imageName: endImageName, zPosition: 100, scale: 0.6)
        addChild(endImage)
        
        let buttonYPosition = size.height * 0.15
        let buttonSpacing: CGFloat = 10
        
        let centerOffset = (size.width * 0.2 + buttonSpacing) / 2

        let restartButton = createButtons(imageName: "PlayAgain", buttonName: "startBut")
        restartButton.position = CGPoint(x: size.width / 2 + centerOffset, y: buttonYPosition)
        addChild(restartButton)
        
        let resetButton = createButtons(imageName: "Exit", buttonName: "resetBut")
        resetButton.position = CGPoint(x: size.width / 2 - centerOffset, y: buttonYPosition)
        addChild(resetButton)
    }
    
    //play again
    func resetGame() {
        SoundManager.shared.stopAllMusic()
        self.removeAllChildren()
        resetGameState()
        SoundManager.shared.setupBackgroundMusic(soundName: "BGM", withExtension: "mp3")
    }
    
    // Function to restart the game
    func restartGame() {
        SoundManager.shared.stopAllMusic()
        playerNode.isHidden = false
        playerNode.physicsBody?.isDynamic = true
        SoundManager.shared.setupBackgroundMusic(soundName: "BG1", withExtension: "mp3")
     NotificationCenter.default.post(name: Notification.Name("resetBut"), object: nil)

    }
    
    // Helper methods
    private func invalidateTimers() {
        enemyTimer.invalidate()
        scoreTimer.invalidate()
    }
    
    private func resetGameState() {
        SoundManager.shared.stopBackgroundMusic() // Ensure this is called to stop win/lose music

        isGameOver = false
        score = 10
        countdown = 60
        self.view?.isPaused = false
        playerNode.isHidden = false
        setupScene()
        setupPlayer()
        setupTimers()
    }
    
    func createBackground(imageName: String, zPosition: CGFloat) -> SKSpriteNode {
        let background = SKSpriteNode(imageNamed: imageName)
        background.zPosition = zPosition
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.size = size
        return background
    }
    
    private func createImage(imageName: String, zPosition: CGFloat, scale: CGFloat) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: imageName)
        node.zPosition = zPosition
        let newScale = scale + 0.1 
        node.scale(to: CGSize(width: size.width * newScale, height: size.height * newScale))
        node.position = CGPoint(x: size.width / 2, y: size.height * 0.55)
        return node
    }
    
    private func createButtons(imageName: String, buttonName: String) -> SKSpriteNode {
        let node = SKSpriteNode(imageNamed: imageName)
        let buttonYPosition = size.height * 0.15
        node.zPosition = 100
        node.scale(to: CGSize(width: size.width * 0.2, height: size.height * 0.2))
        node.position = CGPoint(x: size.width / 2, y: buttonYPosition)
        node.name = buttonName
        return node
    }
}
