//
//  ShopScene.swift
//  SPEEDBOAT
//
//  Created by Mr. Joker on 9/5/19.
//  Copyright © 2019 ORI GAME. All rights reserved.
//

import Foundation
import SpriteKit

class ShopScene : Scene  {
    
    var currentCoin = UserDefaults.standard.integer(forKey: GameConfig.currentCoin)
    let coinSpr = Sprite(imageNamed: "img_coin_back", size: CGSize.withPercentScaledByWidth(28, height: 10), position: CGPoint.withPercent(50, y: 85), zPosition: GameConfig.zPosition.layer_3)
    let coinLbl = Label(text: "0", fontSize: 30, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_5)
    
    let shopSpr = Sprite(imageNamed: "img_shop_back", size: CGSize.withPercentScaled(roundByWidth: 75), position: CGPoint.withPercent(50, y: 40), zPosition: GameConfig.zPosition.layer_3)
    let bloodBtn = Button(normalName: "img_buy_blood", size: CGSize.withPercentScaledByWidth(50, height: 20), position: CGPoint.withPercent(10, y: 93), zPosition: GameConfig.zPosition.layer_3)
    let protectBtn = Button(normalName: "img_buy_protect", size: CGSize.withPercentScaledByWidth(50, height: 20), position: CGPoint.withPercent(10, y: 93), zPosition: GameConfig.zPosition.layer_3)
    
    var currentBlood = UserDefaults.standard.integer(forKey: GameConfig.currentBlood)
    let bloodSpr = Sprite(imageNamed: "img_blood", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_3)
    let bloodDotSpr = Sprite(imageNamed: "img_dot", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_3)
    let bloodLbl = Label(text: "0", fontSize: 20, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_5)
    
    var currentProtect = UserDefaults.standard.integer(forKey: GameConfig.currentProtect)
    let protectSpr = Sprite(imageNamed: "img_protect", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_3)
    let protectDotSpr = Sprite(imageNamed: "img_dot", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_3)
    let protectLbl = Label(text: "0", fontSize: 20, fontName: GameConfig.fontNumber, color: UIColor.white, position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_5)
    
    let toastLbl = Label(text: "You do not have enough coins to buy!", fontSize: 20, fontName: GameConfig.fontNumber, color: UIColor.red, position: CGPoint.zero, zPosition: GameConfig.zPosition.layer_5)
    
    override func didMove(to view: SKView) {
        
        addChild([backgroundSpr, backBtn, coinLbl, coinSpr, shopSpr, bloodBtn, protectBtn, bloodSpr, protectSpr, bloodDotSpr, bloodLbl, protectDotSpr, protectLbl, toastLbl])

        coinLbl.text = String(UserDefaults.standard.integer(forKey: GameConfig.currentCoin))
        coinLbl.position = CGPoint(x: coinSpr.frame.midX + 10, y: coinSpr.frame.midY)
        updateCoin(0)
        
        GameViewHelper.alignItemsVerticallyWithPadding(padding: 30, items: [bloodBtn, protectBtn], position: shopSpr.position)
        
        GameViewHelper.alignItemsHorizontallyWithPadding(padding: 50, items: [bloodSpr, protectSpr], position: CGPoint.withPercent(50, y: 70))
        
        bloodDotSpr.position = CGPoint(x: bloodSpr.frame.maxX, y: bloodSpr.frame.maxY)
        bloodLbl.position = bloodDotSpr.position
        updateBlood(0)
        
        protectDotSpr.position = CGPoint(x: protectSpr.frame.maxX, y: protectSpr.frame.maxY)
        protectLbl.position = protectDotSpr.position
        updateProtect(0)
        
        toastLbl.isHidden = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            //Check press to switch
            soundBtn.changeSwitchState(ifInLocation: location)
            
            touchDownButtons(atLocation: location)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let location = touch.location(in: self)
            
            if backBtn.contains(location) {
                self.changeSceneTo(scene: MenuScene(size: self.size))
            }
            else if bloodBtn.contains(location) {
                onBloodTouched()
            }
            else if protectBtn.contains(location) {
                onProtectTouched()
            }
        }
        
        touchUpAllButtons()
    }
    
    func updateCoin(_ value: Int) {
        currentCoin += value
        
        coinLbl.text = String(currentCoin)
        
        UserDefaults.standard.set(currentCoin, forKey: GameConfig.currentCoin)
    }
    
    func updateBlood(_ value: Int) {
        currentBlood += value
        
        bloodLbl.text = String(currentBlood)
        
        UserDefaults.standard.set(currentBlood, forKey: GameConfig.currentBlood)
    }
    
    func updateProtect(_ value: Int) {
        currentProtect += value
        
        protectLbl.text = String(currentProtect)
        
        UserDefaults.standard.set(currentProtect, forKey: GameConfig.currentProtect)
    }
    
    func onBloodTouched() {
        if currentCoin >= 5 {
            updateCoin(-5)
            updateBlood(1)
        }
        else {
            showToast(bloodBtn.position)
        }
    }
    
    func onProtectTouched() {
        if currentCoin >= 10 {
            updateCoin(-10)
            updateProtect(1)
        }
        else {
            showToast(protectBtn.position)
        }
    }
    
    func showToast(_ pos: CGPoint) {
        toastLbl.position = pos
        toastLbl.removeAllActions()
        toastLbl.run(SKAction.sequence([SKAction.unhide(), SKAction.moveBy(x: 0, y: 100, duration: 1.0), SKAction.hide()]))
    }
}
