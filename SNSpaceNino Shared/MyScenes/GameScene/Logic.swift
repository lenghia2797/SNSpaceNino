//
//  GameLayer.swift
//  GOALKR
//
//  Created by Admin on 7/31/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func touchOnScreen(atLocation pos: CGPoint) {
        if !onDelay {
            if buttonType == Type.rocket.rawValue {
                addRocket(atLocation: pos)
            } else if buttonType == Type.laze.rawValue {
                addLaze(x: pos.x)
            }
            onDelay = true
            self.run(.sequence([
                .wait(forDuration: 0.4),
                .run {self.onDelay = false}
            ]))
        }
    }
    
    func addRocket(atLocation pos: CGPoint) {
        let name = "_rocket_\(Int.random(in: 1...4))"
        let r = RocketObject(imageNamed: name, size: .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/" + name).size(), _sizeofNode: .withPercentScaled(roundByWidth: 8)), position: .withPercent(CGFloat.random(in: -5...105), y: 0), zPosition: 3)
        
        r.physicsBody = SKPhysicsBody(circleOfRadius: r.size.width/2)
        r.physicsBody?.affectedByGravity = false
        r.physicsBody?.categoryBitMask = physicsDefine.rocket.rawValue
        r.physicsBody?.contactTestBitMask = physicsDefine.enemy.rawValue
        r.physicsBody?.collisionBitMask = 0
        
        addChild(r)
        let timeMove = calDistance(pos0: r.position, pos1: pos) / 200
        r.fire(to: pos, duration: timeMove)
        rockets.append(r)
        r.run(.sequence([
            .wait(forDuration: timeMove),
            .run {
                self.addExplodeEffect(pos: pos, imageNamed: "_bomb_explode")
                self.rockets.remove(r)
                r.removeAll()
            }
        ]))
        
    }
    
    func addLaze(x: CGFloat) {
        let laze = Sprite(imageNamed: "_line", size: .withPercent(0.1, height: 100), position: CGPoint(x: x, y: self.size.height/2), zPosition: 3)
        
        laze.physicsBody = SKPhysicsBody(rectangleOf: .withPercent(2, height: 100))
        laze.physicsBody?.affectedByGravity = false
        laze.physicsBody?.categoryBitMask = physicsDefine.laze.rawValue
        laze.physicsBody?.contactTestBitMask = physicsDefine.enemy.rawValue
        laze.physicsBody?.collisionBitMask = 0
        
        laze.run(.sequence([
            .scale(to: .withPercent(2, height: 100), duration: 0.25),
            .removeFromParent()
        ]))
        
        addChild(laze)
    }
    
    func coliRocketEnemy(_rocket: RocketObject, _enemy: EnemyObject) {
        for e in enemies where e == _enemy {
            for r in rockets where r == _rocket {
                if !e.haveShield {
                    rockets.remove(r)
                    r.removeAll()
                    enemies.remove(e)
                    e.removeAll()
                    addExplodeSksFile(pos: e.position, fileNamed: "Explode_1")
                    updateScore(value: 1, position: e.position)
                } else {
                    r.removeAll()
                    rockets.remove(r)
                    addExplodeEffect(pos: r.position, imageNamed: "_bomb_explode")
                    e.updateHealth(value: -0.2)
                    if e.health.progressX <= 0 {
                        enemies.remove(e)
                        e.removeAll()
                        addExplodeSksFile(pos: e.position, fileNamed: "Explode_1")
                        updateScore(value: 1, position: e.position)
                    }
                }
            }
        }
    }
    
    func coliLazeEnemy(_enemy: EnemyObject) {
        for e in enemies where e == _enemy {
            if e.haveShield {
                e.updateHealth(value: -0.5)
                if e.health.progressX <= 0 {
                    enemies.remove(e)
                    e.removeAll()
                    addExplodeSksFile(pos: e.position, fileNamed: "Explode_1")
                    updateScore(value: 1, position: e.position)
                }
            } else {
                e.updateHealth(value: -0.15)
                if e.health.progressX <= 0 {
                    enemies.remove(e)
                    e.removeAll()
                    addExplodeSksFile(pos: e.position, fileNamed: "Explode_1")
                    updateScore(value: 1, position: e.position)
                }
            }
        }
    }
    
    func coliEnemyGround() {
        heartMng.updateHeart(value: -1)
        if heartMng.heartCount < 0 {
            self.changeSceneTo(scene: EndScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
        }
    }
    
    func changeButtonTypeTo(type: Int) {
        buttonType = type
    }
    
    
    func addExplodeSksFile(pos: CGPoint, fileNamed: String) {
        if let ex = SKEmitterNode(fileNamed: fileNamed) {
            ex.position = pos
            addChild(ex)
        }
    }
    
    func passLevel() {
        if level != 15 {
            UserDefaults.standard.set(level+1 , forKey: GameConfig.level)
            
            if mode == 0 {
                if level + 1 > UserDefaults.standard.integer(forKey: GameConfig.maxLevel){
                    UserDefaults.standard.set(level+1 , forKey: GameConfig.maxLevel)
                }
            } else {
                if level + 1 > UserDefaults.standard.integer(forKey: GameConfig.maxLevelHard){
                    UserDefaults.standard.set(level+1 , forKey: GameConfig.maxLevelHard)
                }
            }
            
            
            Sounds.sharedInstance().playSound(soundName: "Sounds/sound_score.mp3")
            self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .doorsOpenHorizontal(withDuration: 0.5))
        } else {
            self.changeSceneTo(scene: MenuScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
        }
    }
    
}
