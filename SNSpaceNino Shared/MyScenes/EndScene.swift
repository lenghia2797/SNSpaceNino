//
//  EndScene.swift
//
//
//  Created by  on 4/9/19.
//  Copyright © 2019 . All rights reserved.
//

import Foundation
import SpriteKit



class EndScene : Scene  {

    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        addChild([homeBtn, backgroundSpr, replayBtn])
        
        homeBtn.position = CGPoint.withPercent(40, y: 50)
        replayBtn.position = CGPoint.withPercent(60, y: 50)
        
        setScore()
        
        addChild([scoreLbl, bestLbl])
        
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_over")
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            touchDownButtons(atLocation: location)            //Check press to switch
            
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            if homeBtn.contains(location){
                touchUpAllButtons()
                changeSceneTo(scene: MenuScene(size: self.size), withTransition: .doorsOpenHorizontal(withDuration: 0.5))}
            else if replayBtn.contains(location){
                touchUpAllButtons()
                changeSceneTo(scene: GameScene(size: self.size), withTransition: .push(with: .right, duration: 0.5))
            }
        }
        
        touchUpAllButtons()
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
}
