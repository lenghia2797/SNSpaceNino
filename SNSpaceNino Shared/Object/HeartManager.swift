//
//  HeartManager.swift
//  SKSoldiK iOS
//
//  Created by hehehe on 3/9/22.
//

import Foundation
import SpriteKit

class HeartManager {
    var hearts = [Sprite]()
    var maxHeart = 0
    var heartCount = 0
    
    init(maxHeart: Int, heartCount: Int, position: CGPoint, zPosition: CGFloat) {
        self.maxHeart = maxHeart
        self.heartCount = heartCount
        for _ in 1...maxHeart {
            let heart = Sprite(imageNamed: "_heart.png", size: CGSize.withPercentScaled(roundByWidth: 6), position: CGPoint.zero, zPosition: 3)
            heart.isHidden = true
            hearts.append(heart)
        }
        GameViewHelper.alignItemsHorizontallyWithPadding(padding: 10, items: hearts, position: position)
    }
    
    func displayHeart(value: Int) {
        heartCount = value
        for (index, h) in hearts.enumerated() {
            if index < heartCount {
                h.isHidden = false
                h.run(.sequence([
                    .scale(to: 1.2, duration: 0.1),
                    .scale(to: 1, duration: 0.1),
                    .scale(to: 1.2, duration: 0.1),
                    .scale(to: 1, duration: 0.1)
                ]))
            } else {
                h.isHidden = true
            }
        }
    }
    
    func updateHeart(value: Int) {
        heartCount += value
        displayHeart(value: heartCount)
    }
    
}
