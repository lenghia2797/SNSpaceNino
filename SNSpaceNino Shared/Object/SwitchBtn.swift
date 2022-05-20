//
//  SwitchBtn.swift
//  SKSoldiK iOS
//
//  Created by hehehe on 3/9/22.
//

import Foundation
import SpriteKit

class SwitchBtn : Button {
    
    override init() {
        super.init()
    }

    override init(normalName imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(normalName: imageNamed, size: size, position: position, zPosition: zPosition)
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
