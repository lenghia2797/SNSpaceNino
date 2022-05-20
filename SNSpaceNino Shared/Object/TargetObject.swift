//
//  TargetObject.swift
//  SKSoldiK iOS
//
//  Created by hehehe on 3/6/22.
//

import Foundation
import SpriteKit

class TargetObject : Sprite {
    let target: Sprite = Sprite()
    
    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
        
        addChild(target)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeTarget(name: Int) {
        target.run(.sequence([
            .scale(to: 1.1, duration: 0.5),
            .scale(to: 1, duration: 0.5)
        ]))
        target.texture = SKTexture(imageNamed: "Images/" + "_enemy_\(name)")
        target.size = .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/" + "_enemy_\(name)").size(), _sizeofNode: .withPercentScaled(roundByWidth: 15))
        target.name = String(name)
    }
}
