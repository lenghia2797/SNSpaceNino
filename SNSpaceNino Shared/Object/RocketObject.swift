//
//  RocketObject.swift
//  SKSoldiK iOS
//
//  Created by hehehe on 3/9/22.
//

import Foundation
import SpriteKit

class RocketObject : Sprite {
    
    override init() {
        super.init()
    }

    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func fire(to pos: CGPoint, duration: TimeInterval) {
        self.zRotation = compensationAngle(angle: betaAngle(point0: self.position, point1: pos))
        self.run(.move(to: pos, duration: duration))
    }
    
    func removeAll() {
        self.removeAllActions()
        self.removeAllChildren()
        self.removeFromParent()
    }
}
