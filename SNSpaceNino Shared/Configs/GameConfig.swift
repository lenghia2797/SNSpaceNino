//
//  GameConfig.swift
//  
//
//  Created by  on 4/8/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import SpriteKit

struct GameConfig {
    static let currentScore = "CurrentScore"
    static let bestScore = "BestScore"
    static let currentCoin = "currentCoin"
    static let currentBlood = "currentBlood"
    static let currentProtect = "currentProtect"
    static let level = "levelGame"
    static let mode = "modeGame"
    static let maxLevel = "maxLevel"
    static let maxLevelHard = "maxLevelHard"
    
    static let hasLaunchedOnce = "HasLaunchedOnce"
    static let neverRateAfterGame =  "NeverRateAfterGame"
    
    static let fontText:String = "ICIELCADENA"
    static let fontNumber:String = "ICIELCADENA"
    // 249, 217 140
    static let textColor:UIColor = #colorLiteral(red: 0.9899655032, green: 0.8797091898, blue: 0.03754508835, alpha: 1)
    struct zPosition {
        static let layer_1:CGFloat = 0
        static let layer_2:CGFloat = 1
        static let layer_3:CGFloat = 2
        static let layer_4:CGFloat = 3
        static let layer_5:CGFloat = 4
    }
}
