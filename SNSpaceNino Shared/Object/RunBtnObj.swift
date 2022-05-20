//
//  RunBtnObj.swift
//  ShotaSunAA iOS
//
//  Created by hehehe on 2/19/22.
//

import Foundation
import SpriteKit

class RunBtnObj : Button {
    var onDelay = false
    
    override init() {
        super.init()
    }
    
    override init(normalName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(normalName: normalName, size: size, position: position, zPosition: zPosition)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
