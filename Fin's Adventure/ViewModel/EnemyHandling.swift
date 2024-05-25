//
//  EnemyHandling.swift
//  Fin's Adventure
//
//  Created by Afrah Saleh on 01/08/1445 AH.
//

import SpriteKit
import GameplayKit

extension GameScene {
    @objc func spawnEnemy() {
        let randomYPosition = GKRandomDistribution(lowestValue: 20, highestValue: 80)
        let itemType = Int.random(in: 1...4)
        let imageName = determineItem(forItemType: itemType)
        let item = SKSpriteNode(imageNamed: imageName)
        item.position = CGPoint(x: 400, y: randomYPosition.nextInt())
        item.setScale(0.02)
        item.zPosition = 5
        setPhysicsBody(for: item, withType: itemType)
        addChild(item)
        
        let moveAcrossScreen = SKAction.moveTo(x: -10, duration: 5)
        let bobUp = SKAction.moveBy(x: 0, y: 10, duration: 0.5)
        let bobDown = SKAction.moveBy(x: 0, y: -10, duration: 0.5)
        let bobbing = SKAction.sequence([bobUp, bobDown])
        let continuousBobbing = SKAction.repeatForever(bobbing)
        
        item.run(SKAction.group([moveAcrossScreen, continuousBobbing]), completion: item.removeFromParent)
    }
    
    private func determineItem(forItemType itemType: Int) -> String {
        switch itemType {
        case 1: return "badItem1"
        case 2: return "badItem2"
        case 3: return "badItem3"
        case 4: return "goodItem1"
        default: return "badItem1"
        }
    }
    
    private func setPhysicsBody(for item: SKSpriteNode, withType itemType: Int) {
        item.physicsBody = SKPhysicsBody(rectangleOf: item.size)
        item.physicsBody?.isDynamic = false
        item.physicsBody?.contactTestBitMask = 1
        item.name = itemType == 4 ? "goodItem" : "badItem"
    }
}
