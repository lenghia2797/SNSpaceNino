//
//  NewMenuScene.swift
//  B-RUNN
//
//  Created by ldmanh on 6/1/20.
//  Copyright © 2020 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class MenuScene : Scene  {
    
    let mode0Btn = Button(normalName: "normal.png", size: CGSize.zero, position: CGPoint.withPercent(50, y: 40), zPosition: GameConfig.zPosition.layer_3)
    let mode1Btn = Button(normalName: "hard.png", size: CGSize.zero, position: CGPoint.withPercent(50, y: 60), zPosition: GameConfig.zPosition.layer_3)
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        mode0Btn.size = .sizeOfNode(_sizeOfTexture: SKTexture(imageNamed: "Images/normal").size(), _sizeofNode: .withPercentScaled(roundByWidth: 25))
        mode1Btn.size = mode0Btn.size
        
        soundBtn.position = .withPercent(50, y: 20)
        addChild([backgroundSpr,  soundBtn])
        
        addChildScaleAnimation([mode1Btn, mode0Btn], duration: 0.3)
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
            soundBtn.changeSwitchState(ifInLocation: location)
            
            if mode0Btn.contains(location) {
                UserDefaults.standard.set(0, forKey: GameConfig.mode)
                self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            } else if mode1Btn.contains(location) {
                UserDefaults.standard.set(1, forKey: GameConfig.mode)
                self.changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .left, duration: 0.5))
            }
            soundBtn.run(SKAction.scale(to: 1.0, duration: 0.025))
        }
        
        touchUpAllButtons()
    }
}
