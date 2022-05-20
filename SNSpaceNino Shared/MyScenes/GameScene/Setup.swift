//
//  ControlLayer.swift
//  GOALKR
//
//  Created by Admin on 7/31/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func setupGame() {
        setInterFace()

        addEnemies()
        
        addFireBtn()
        
        addGround()
        
        addHeart()
    }
    
    func setInterFace() {
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -5)
        soundBtn.position = .withPercent(30, y: 92)
        scoreLbl.position = .withPercent(75, y: 92)
        UserDefaults.standard.set(0, forKey: GameConfig.currentScore)
        addChild([backBtn, backgroundSpr, soundBtn, scoreLbl])
        scoreLbl.text = "Score: \(score), Best: \(best)"
    }
    
    
    
    func addEnemies() {

        if mode == 1 {
            addEnemy()
            if Bool.random() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    self.addEnemy()
                }
            }
        }
        addEnemy()
        if Bool.random() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.addEnemy()
            }
        }
        

        self.run(.sequence([
            .wait(forDuration: 2),
            .run {
                self.addEnemies()
            }
        ]))
    }

    func addEnemy() {
        let randInt = Int.random(in: 1...6)
        let name = "_enemy_\(randInt)"
        let randPos = CGPoint.withPercent(CGFloat.random(in: -5...105), y: 100)
        let randPos2 = CGPoint.withPercent(CGFloat.random(in: 5...95), y: -2)
        let enemy = EnemyObject(imageNamed: name, size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/" + name).size(), _sizeofNode: .withPercentScaled(roundByWidth: 13)), position: randPos, zPosition: 3)
        
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: enemy.size.width/2)
        enemy.physicsBody?.affectedByGravity = false
        enemy.physicsBody?.categoryBitMask = physicsDefine.enemy.rawValue
        enemy.physicsBody?.contactTestBitMask = physicsDefine.rocket.rawValue | physicsDefine.laze.rawValue | physicsDefine.ground.rawValue
        enemy.physicsBody?.collisionBitMask = 0
        
        enemy.name = String(randInt)

        addChild(enemy)
        enemies.append(enemy)
        
        enemy.run(.sequence([
            .move(to: randPos2, duration: TimeInterval.random(in: 12...20)),
            .removeFromParent(),
            .run {
                self.enemies.remove(enemy)
            }
                
        ]))
    }
    
    func addFireBtn() {
        addChild(fireBtn)
    }
    
    func addGround() {
        let ground = Sprite(imageNamed: "_line", size: .withPercent(100, height: 2), position: .withPercent(50, y: -1), zPosition: 3)
        ground.isHidden = true
        ground.physicsBody = SKPhysicsBody(rectangleOf: ground.size)
        ground.physicsBody?.affectedByGravity = false
        ground.physicsBody?.categoryBitMask = physicsDefine.ground.rawValue
        ground.physicsBody?.contactTestBitMask = physicsDefine.enemy.rawValue
        ground.physicsBody?.collisionBitMask = 0
        addChild(ground)
    }
    
    
    func addHeart() {
        for h in heartMng.hearts {
            addChild(h)
        }
        if mode == 0 {
            heartMng.displayHeart(value: 4)
        } else {
            heartMng.displayHeart(value: 3)
        }
        
    }
    
    func setLevelLbl() {
        
        toastLbl.text = "Level : \(level)"
        showToast(CGPoint.withPercent(50, y: 40))
        levelLbl.changeTextWithAnimationScaled(withText: "Level : \(level)")
//        levelLbl.attributedText = setStrokeForTextLbl(label: levelLbl)
        
        addChild([ levelLbl, toastLbl])
        Sounds.sharedInstance().playSound(soundName: "Sounds/level_up.mp3")
    }
    
    func showToast(_ pos: CGPoint) {
        toastLbl.position = pos
        toastLbl.removeAllActions()
        toastLbl.run(SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 100, duration: 1.0), SKAction.hide()]))
    }
    
    func addProgressbar() {
        addChild(progressBar)
        progressBar.setProgressbar(scale: 0.22, position: .withPercent(75, y: 87), zPosition: 3)
    }
    
    func calDistance(pos0: CGPoint, pos1: CGPoint) -> Double {
        return Double(sqrt(pow(pos1.y-pos0.y, 2) + pow(pos1.x - pos0.x, 2)))
    }
    
    func addExplodeEffect(pos : CGPoint, imageNamed: String) {
        let bombLbl = Sprite(imageNamed: imageNamed, size: CGSize.withPercentScaled(roundByHeight: 5), position: pos, zPosition: 3)
        bombLbl.run(SKAction.sequence([SKAction.scale(by: 1.5, duration: 0.3),
                                          SKAction.removeFromParent()
        ]))
        
        addChild([bombLbl])
        
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_fail.mp3")
    }
    
    func setStrokeForTextLbl(label : Label) -> NSMutableAttributedString {
        let strokeTextAttributes = [
            NSAttributedString.Key.font : UIFont(name: GameConfig.fontText, size: label.fontSize) ?? UIFont.boldSystemFont(ofSize: label.fontSize),
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.strokeColor : UIColor.blue,
            NSAttributedString.Key.strokeWidth : -4.0
            
        ] as [NSAttributedString.Key : Any]
        
        return NSMutableAttributedString(string: label.text ?? "LabelStroke", attributes: strokeTextAttributes)
    }
    
    func setScoreLbl() {
        
        scoreLbl.position = CGPoint.withPercent(50, y: 89)
        
        UserDefaults.standard.set(0, forKey: GameConfig.currentScore)
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score) , Best: \(best)")
        scoreLbl.fontSize = 25
//        scoreLbl.attributedText = setStrokeForTextLbl(label: scoreLbl)
        
        addChild(scoreLbl)
        
    }
    
    
}
