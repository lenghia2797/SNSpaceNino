//
//  EnemyObject.swift
//  SKSoldiK iOS
//
//  Created by hehehe on 3/6/22.
//

import Foundation
import SpriteKit

class EnemyObject : Sprite {
    let node = SKSpriteNode()
    var childs = [Sprite]()
    var isBig = false
    var isDuplicate = Bool.random()
    var isDuplicate2 = Bool.random()
    
    let haveShield = Bool.random()
    var shield = Sprite()
    var health = IMProgressBar(emptyImageName: "spr_progress_bar", filledImageName: "spr_progress_bar_level")
    override init() {
        super.init()
    }
    
    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
        if haveShield {
            shield = Sprite(imageNamed: "_line", size: CGSize(width: 30, height: 5), position: CGPoint(x: 0, y: -20), zPosition: 1)
            addChild(shield)
        }
        health.setProgressbar(scale: 0.07, position: CGPoint(x: 0, y: 20), zPosition: 3)
        addChild(health)
        health.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateHealth(value: CGFloat) {
        health.updateProgressX(value: value)
        health.isHidden = false
    }
    
    func removeAll() {
        self.removeAllChildren()
        self.removeAllActions()
        self.removeFromParent()
    }
}
