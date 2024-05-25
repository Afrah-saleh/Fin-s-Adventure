//
//  setupPlayer.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 01/08/1445 AH.
//

import Foundation
import SpriteKit
import Foundation
import GameplayKit

extension GameScene {
    func setupPlayer() {
        playerNode.position = CGPoint(x: size.width / 2, y: playerNode.size.height / 2)
          
        playerNode.setScale(0.03)
        playerNode.xScale = 0.05
          
        playerNode.physicsBody = SKPhysicsBody(rectangleOf: playerNode.size)
        playerNode.physicsBody?.categoryBitMask = 1
        playerNode.physicsBody?.allowsRotation = false
        playerNode.zPosition = 10
          addChild(playerNode)
      }
      
    // Function to handle player movement
    func handlePlayerMovement() {
        if isTouchingScreen {
            playerNode.physicsBody?.velocity = CGVector(dx: 0, dy: 60)
        }
        if playerNode.position.y > 90 {
            playerNode.position.y = 90
        }
    }
      
  }

