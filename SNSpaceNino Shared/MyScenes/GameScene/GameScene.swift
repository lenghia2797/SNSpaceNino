//
//  GameScene.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 8/13/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

enum Type: Int {
    case rocket = 1
    case laze = 2
}


class GameScene : Scene, SKPhysicsContactDelegate {
    
    var backgrounds = [Sprite()]
              
    var gameEnd:Bool = false
    var level:Int = UserDefaults.standard.integer(forKey: GameConfig.level)
    let toastLbl = Label(text: "Level: ", fontSize: 35, fontName: GameConfig.fontText, color: GameConfig.textColor, position: CGPoint.zero, zPosition: 7)
    let levelLbl = Label(text: "Level: 1", fontSize: 35, fontName: GameConfig.fontText, color: GameConfig.textColor, position: CGPoint.withPercent(50, y: 90), zPosition: 7)
    
    enum physicsDefine:UInt32 {
        case rocket = 1
        case laze = 2
        case enemy = 4
        case ground = 8
    }
    
    // GameLayer
    var location0: CGPoint = CGPoint.zero
    var isProcessing: Bool = false
    
    var progressBar = IMProgressBar(emptyImageName: "spr_progress_bar",filledImageName: "spr_progress_bar_level")
    
    var moveNode:SKNode?
    
    
    let mode = UserDefaults.standard.integer(forKey: GameConfig.mode)
    
    
    // New
    var enemies = [EnemyObject]()
    
    var rockets = [RocketObject]()
    
    let fireBtn = ToggleButton(imageOn: "_rocket_btn", imageOff: "_laze_btn", size: .withPercentScaled(roundByWidth: 13), position: .withPercent(12, y: 10), zPosition: 3)
    
    var buttonType: Int = Type.rocket.rawValue
    var onDelay = false
    
    let heartMng = HeartManager(maxHeart: 4, heartCount: 3, position: .withPercent(75, y: 88), zPosition: 3)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        self.physicsWorld.contactDelegate = self
        
        setupGame()
        
    }
    
    override func update(_ currentTime: TimeInterval) {
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if soundBtn.contains(location) {
                soundBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            } else if fireBtn.contains(location) {
                fireBtn.run(SKAction.scale(to: 0.85, duration: 0.025))
            }
            touchDownButtons(atLocation: location)
            location0 = location
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, moveNode != nil {
            let location = touch.location(in: self)

//            moveNode?.run(.move(to: location, duration: 0.2))

        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if soundBtn.contains(location) {
                soundBtn.changeSwitchState()
            } else if backBtn.contains(location) {
                self.changeSceneTo(scene: MenuScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
            } else if fireBtn.contains(location) {
                fireBtn.changeSwitchState()
                if fireBtn.currentState {
                    changeButtonTypeTo(type: Type.rocket.rawValue)
                } else {
                    changeButtonTypeTo(type: Type.laze.rawValue)
                }
            } else {
                touchOnScreen(atLocation: location)
            }
            
        }
        fireBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        touchUpAllButtons()
        
    }
    
    func didBegin(_ contact : SKPhysicsContact) {
        let contactMark = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody

        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask){
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        if gameEnd==false {
            switch contactMark {
            case physicsDefine.rocket.rawValue | physicsDefine.enemy.rawValue:
                guard firstBody.node == nil || secondBody.node == nil else {
                    coliRocketEnemy(_rocket: firstBody.node as! RocketObject, _enemy: secondBody.node as! EnemyObject)
                    return
                }
            case physicsDefine.laze.rawValue | physicsDefine.enemy.rawValue:
                guard firstBody.node == nil || secondBody.node == nil else {
                    coliLazeEnemy(_enemy: secondBody.node as! EnemyObject)
                    return
                }
            case physicsDefine.enemy.rawValue | physicsDefine.ground.rawValue:
                coliEnemyGround()
            default:
                return
            }
        }
    }
    
}
