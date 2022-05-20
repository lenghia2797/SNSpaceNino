//
//  UpdateLayer.swift
//  AnimalShape
//
//  Created by hehehe on 7/1/21.
//

import Foundation
import SpriteKit

extension GameScene {
    func checkEnemiesForDuplicate() {
        for e in enemies where (e.position.y < self.size.height*0.7 && !e.isDuplicate) {
            e.isDuplicate = true
            let e2:EnemyObject = e.copy() as! EnemyObject
            e2.isDuplicate = true
            addChild(e2)
            enemies.append(e2)
        }
        for e in enemies where (e.position.y < self.size.height*0.4 && !e.isDuplicate2) {
            e.isDuplicate2 = true
            let e2:EnemyObject = e.copy() as! EnemyObject
            e2.isDuplicate = true
            e2.isDuplicate2 = true
            addChild(e2)
            enemies.append(e2)
        }
    }
    
    
    func moveBackGround() {
        self.enumerateChildNodes(withName: "background") { (node, error) in
            node.position.y -= 0.85
            if node.position.y < -self.size.height/2 {
                node.position.y += self.size.height*3
            }
        }
         
    }
    
    func updateScore( value:Int, position:CGPoint) {
        
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        score += value
        if (score > UserDefaults.standard.integer(forKey: GameConfig.bestScore)) {
            UserDefaults.standard.set(score, forKey: GameConfig.bestScore)
            best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        }
        UserDefaults.standard.set(score, forKey: GameConfig.currentScore)
        
        if UserDefaults.standard.integer(forKey: GameConfig.mode) == 0 {
            scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score) , Best: \(best)")
        } else {
            scoreLbl.changeTextWithAnimationScaled(withText: "Score: \(score) , Best: \(best)")
        }
        
        
        Sounds.sharedInstance().playSound(soundName: "Sounds/sound_score.mp3")
        let add_oneLbl:Label
        let addLblPos:CGPoint = CGPoint(x: position.x+40, y: position.y+40)
        add_oneLbl = Label(text: "+\(value)", fontSize: 35, fontName: GameConfig.fontText, color: UIColor.red, position: addLblPos, zPosition: 5)

        add_oneLbl.run(SKAction.sequence([SKAction.scale(by: 1.4, duration: 0.5),
                                          SKAction.removeFromParent()
        ]))
        addChild(add_oneLbl)
        
        if let ex = SKEmitterNode(fileNamed: "Explode_3.sks") {
            ex.position = position
            addChild(ex)
        }
        
        
    }
}
