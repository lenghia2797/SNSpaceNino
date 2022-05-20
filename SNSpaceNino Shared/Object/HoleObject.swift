//
//  HoleObject.swift
//  PPColorGA iOS
//
//  Created by hehehe on 3/5/22.
//

import Foundation
import SpriteKit

class HoleObject : Sprite {
    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeHolePosition() {
        position = .withPercent(.random(in: 15...85), y: .random(in: 30...70))
    }
}
