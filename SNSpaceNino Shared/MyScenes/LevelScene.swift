//
//  LevelScene.swift
//  IQBALL
//
//  Created by Admin on 8/5/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class LevelButton : Button {
    override init() {
            super.init()
            
        }
//    var nameLevel:Int = 0
    var isLock:Bool = true
    
    override init(normalName: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(normalName: normalName, size: size, position: position, zPosition: zPosition)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class LevelScene : Scene {
    
    var levels = [LevelButton()]
    
    var posLevelArr = Array(repeating: Array(repeating: CGPoint.zero, count: 100), count: 100)
    
    var maxLevel = 0
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        let mode = UserDefaults.standard.integer(forKey: GameConfig.mode)
        if mode == 0 {
            maxLevel = UserDefaults.standard.integer(forKey: GameConfig.maxLevel)
        } else {
            maxLevel = UserDefaults.standard.integer(forKey: GameConfig.maxLevelHard)
        }
        
        
        addChild([soundBtn, backgroundSpr, backBtn])
        
        createLevel()
        
//        addRope()
        
//        addLevelBack()
    }
    
    func createLevel(){
        for i in 0...4 {
            for j in 0...2 {
                let level = LevelButton(normalName: "empty_btn.png", size: CGSize.withPercentScaled(roundByWidth: 13), position: positionOfLevelBtnVertical(_levelNameInt: i*3+j+1), zPosition: 2)
                
                level.name = String(i*3+j+1)
                
                let levelText = Label(text: level.name ?? "0", fontSize: 25, fontName: GameConfig.fontText, color: GameConfig.textColor, position: .zero, zPosition: 3)
                if maxLevel == i*3+j+1 {
                    levelText.color = #colorLiteral(red: 0.8538960478, green: 0.1963254814, blue: 1, alpha: 1)
                }
                level.addChild(levelText)
                
                let lockSpr = Sprite(imageNamed: "lock.png", size: CGSize.withPercentScaled(roundByWidth: 5), position: .zero, zPosition: 3)
                lockSpr.color = #colorLiteral(red: 1, green: 0.5612908671, blue: 0.05009495007, alpha: 1)
                lockSpr.colorBlendFactor = 1.0
                
                level.addChild(lockSpr)
                
                addChildScaleAnimation(level, duration: 0.3)
                
                levelText.isHidden = true
                if Int(level.name!) ?? 1 <= maxLevel {
                    lockSpr.isHidden = true
                    level.isLock = false
                    levelText.isHidden = false
                }
                levels.append(level)
                
                buttons.append(level)
            }
        }
    }
    
    func addRope() {
        for i in 1...15 {
            
            switch i {
            case 1,3,7,9,13:
                let rope = Sprite(imageNamed: "rope_2", size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/rope_2").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 11.67)), position: CGPoint(x: (posOfLevel(levelName: i).x + posOfLevel(levelName: i+1).x)/2, y: (posOfLevel(levelName: i).y + posOfLevel(levelName: i+1).y)/2), zPosition: 1.9)
                addChild(rope)
                break
            case 2,8,14:
                let rope = Sprite(imageNamed: "rope_2", size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/rope_2").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 11.67)), position: CGPoint(x: (posOfLevel(levelName: i).x + posOfLevel(levelName: i+1).x)/2, y: (posOfLevel(levelName: i).y + posOfLevel(levelName: i+1).y)/2), zPosition: 1.9)
                rope.yScale = -1
                addChild(rope)
                break
            case 4,6,10,12:
                let rope = Sprite(imageNamed: "rope_2", size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/rope_2").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 26)), position: CGPoint(x: (posOfLevel(levelName: i).x + posOfLevel(levelName: i+1).x)/2, y: (posOfLevel(levelName: i).y + posOfLevel(levelName: i+1).y)/2), zPosition: 1.9)
                rope.zRotation = -1 * .pi/4
                addChild(rope)
                break
            case 5,11:
                let rope = Sprite(imageNamed: "rope_2", size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/rope_2").size(), _sizeofNode: CGSize.withPercentScaled(roundByWidth: 26)), position: CGPoint(x: (posOfLevel(levelName: i).x + posOfLevel(levelName: i+1).x)/2, y: (posOfLevel(levelName: i).y + posOfLevel(levelName: i+1).y)/2), zPosition: 1.9)
                rope.yScale = -1
                rope.zRotation = -1 * .pi/4
                addChild(rope)
                break
            default:
                break
            }
            
        }
        
    }
    
    func posOfLevel(levelName: Int) -> CGPoint {
        for l in levels {
            if l.name == String(levelName) {
                return l.position
            }
            
        }
        return CGPoint.zero
    }
    
    func addLevelBack() {
        for i in 1...5 {
            let levelBack = Sprite(imageNamed: "empty_btn.png", size: CGSize.withPercentScaledByWidth(55, height: 55/2.39), position: CGPoint.zero, zPosition: 1)
            addChild(levelBack)
            switch i {
            case 1:
                levelBack.position = CGPoint.withPercent(35, y: 17.5)
                break
            case 2:
                levelBack.position = CGPoint.withPercent(65, y: 32.5)
                break
            case 3:
                levelBack.position = CGPoint.withPercent(40, y: 47.5)
                break
            case 4:
                levelBack.position = CGPoint.withPercent(70, y: 62.5)
                break
            
            default:
                levelBack.position = CGPoint.withPercent(50, y: 77.5)
            }
        }
        
    }
    
    func positionOfLevelBtnVertical(_levelNameInt : Int) -> CGPoint {
        let minY:CGFloat = 15
        let maxY:CGFloat = 80
        let dY:CGFloat = (maxY - minY)/6
        
        let minX:CGFloat = 17
        let maxX:CGFloat = 83
//        let dX:CGFloat = (maxY - minY)/3
        let mediumX:CGFloat = (maxX + minX)/2
        
        
        switch _levelNameInt {
        case 1:
            return CGPoint.withPercent(minX, y: minY)
        case 2:
            return CGPoint.withPercent(mediumX, y: minY)
        case 3:
            return CGPoint.withPercent(maxX, y: minY)
        case 4:
            return CGPoint.withPercent(maxX, y: minY + dY)
        case 5:
            return CGPoint.withPercent(maxX, y: minY + dY*2)
        case 6:
            return CGPoint.withPercent(mediumX, y: minY + dY*2)
        case 7:
            return CGPoint.withPercent(minX, y: minY + dY*2)
        case 8:
            return CGPoint.withPercent(minX, y: minY + dY*3)
        case 9:
            return CGPoint.withPercent(minX, y: minY + dY*4)
        case 10:
            return CGPoint.withPercent(mediumX, y: minY + dY*4)
        case 11:
            return CGPoint.withPercent(maxX, y: minY + dY*4)
        case 12:
            return CGPoint.withPercent(maxX, y: minY + dY*5)
        case 13:
            return CGPoint.withPercent(maxX, y: minY + dY*6)
        case 14:
            return CGPoint.withPercent(mediumX, y: minY + dY*6)
        case 15:
            return CGPoint.withPercent(minX, y: minY + dY*6)
        default:
            return CGPoint.withPercent(10, y: 10)
        }
 
//
//        let x1:CGFloat = 15
//        let x2:CGFloat = 38.33
//        let x3:CGFloat = 61.67
//        let x4:CGFloat = 85
//        let y1:CGFloat = 15
//        let y2:CGFloat = 15 + 11.67
//        let y3:CGFloat = 15 + 11.67*2
//        let y4:CGFloat = 50
//        let y5:CGFloat = 50 + 11.67
//        let y6:CGFloat = 50 + 11.67*2
//        let y7:CGFloat = 85
//
//        switch _levelNameInt {
//        case 1:
//            return CGPoint.withPercent(x1, y: y1)
//        case 2:
//            return CGPoint.withPercent(x2, y: y1)
//        case 3:
//            return CGPoint.withPercent(x3, y: y1)
//        case 4:
//            return CGPoint.withPercent(x4, y: y1)
//        case 5:
//            return CGPoint.withPercent(x3, y: y2)
//        case 6:
//            return CGPoint.withPercent(x2, y: y3)
//        case 7:
//            return CGPoint.withPercent(x1, y: y4)
//        case 8:
//            return CGPoint.withPercent(x2, y: y4)
//        case 9:
//            return CGPoint.withPercent(x3, y: y4)
//        case 10:
//            return CGPoint.withPercent(x4, y: y4)
//        case 11:
//            return CGPoint.withPercent(x3, y: y5)
//        case 12:
//            return CGPoint.withPercent(x2, y: y6)
//        case 13:
//            return CGPoint.withPercent(x1, y: y7)
//        case 14:
//            return CGPoint.withPercent(x2, y: y7)
//        case 15:
//            return CGPoint.withPercent(x3, y: y7)
//        default:
//            return CGPoint.withPercent(10, y: 10)
//        }
    }
    
    func createPosLevelArray(){
        var posX:CGFloat
        var posY:CGFloat
        let dSquare = self.frame.maxX/CGFloat(4)
        
        for i in 0...4 {
            for j in 0...2 {
                posX = CGFloat( ( CGFloat(j+1)) * dSquare)
                posY = CGFloat( ( CGFloat(5) - CGFloat(i) ) * dSquare )
                posLevelArr[i][j] = CGPoint(x: posX, y: posY + self.frame.maxY*0.08)
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if soundBtn.contains(location) {
                soundBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            }
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if soundBtn.contains(location) {
                soundBtn.changeSwitchState()
                soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
            } else if backBtn.contains(location){
                self.changeSceneTo(scene: MenuScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
            } else {
                for level in levels {
                    if level.contains(location){
                        if !level.isLock {
                            UserDefaults.standard.set(level.name, forKey: GameConfig.level)
                            self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
                        }
                    }
                }
            }
        }
        
        touchUpAllButtons()
    }
        
    
}
