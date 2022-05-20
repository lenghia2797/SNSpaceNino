//
//  BaseScene.swift
//  
//
//  Created by  on 3/21/19.
//  Copyright © 2019 . All rights reserved.
//

import SpriteKit

class Scene : SKScene, ToggleButtonDelegate {
    
    var score: Int = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
    var best: Int = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
    
    var levelScore = 1
    
    var buttons = [Button]()
    
    let backgroundSpr = Sprite.init(imageNamed: "background.png", size: CGSize.withPercent(100, height: 100), position: VisibleRect.center(), zPosition: GameConfig.zPosition.layer_1)
    
    let menuSpr = Sprite.init(imageNamed: "empty_btn.png", size: CGSize.withPercentScaled(roundByWidth: 50), position: VisibleRect.center(), zPosition: 3.9)
    
    let soundBtn = ToggleButton(imageOn: "music-on.png", imageOff: "music-off", size: CGSize.withPercentScaledByWidth(12*1.45, height: 12), position: CGPoint.withPercent(88, y: 92), zPosition: GameConfig.zPosition.layer_5)
    
    let rankingBtn = Button(normalName: "ranking.png", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.withPercent(35, y: 25), zPosition: GameConfig.zPosition.layer_5)
    
    let homeBtn = Button(normalName: "home", size: CGSize.withPercentScaledByWidth(12*1.45, height: 12), position: CGPoint.withPercent(12, y: 92), zPosition: GameConfig.zPosition.layer_5)
    
    let backBtn = Button(normalName: "home", size: CGSize.withPercentScaledByWidth(12*1.45, height: 12), position: CGPoint.withPercent(12, y: 92), zPosition: GameConfig.zPosition.layer_5)
    
    let menuBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 13), position: CGPoint.withPercent(12, y: 92), zPosition: GameConfig.zPosition.layer_5)
    
    let rateBtn = Button(normalName: "rating.png", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.withPercent(35, y: 25), zPosition: GameConfig.zPosition.layer_5)
    
    let playBtn = Button(normalName: "play", size: CGSize.withPercentScaled(roundByWidth: 25), position: CGPoint.withPercent(50, y: 50), zPosition: GameConfig.zPosition.layer_3)
    
    let replayBtn = Button(normalName: "replay", size: CGSize.withPercentScaledByWidth(12*1.45, height: 12), position: CGPoint.withPercent(50, y: 50), zPosition: GameConfig.zPosition.layer_3)

    let howToPlayBtn = Button(normalName: "empty_btn", size: CGSize.withPercentScaled(roundByWidth: 15), position: CGPoint.withPercent(50, y: 35), zPosition: 3)
    
    var scoreLbl = Label(text: "Score: 0", fontSize: 20, fontName: GameConfig.fontNumber, color: GameConfig.textColor, position: CGPoint.withPercent(50, y: 80), zPosition: 7)
    
    var bestLbl = Label(text: "0", fontSize: 20, fontName: GameConfig.fontNumber, color: GameConfig.textColor, position: CGPoint.withPercent(50, y: 70), zPosition: GameConfig.zPosition.layer_2)
    
    let shopBtn = Button(normalName: "img_shop", size: CGSize.withPercentScaled(roundByWidth: 20), position: CGPoint.withPercent(50, y: 15), zPosition: GameConfig.zPosition.layer_3)
    
    let homeBtnContent = Sprite(imageNamed: "home", size: CGSize.withPercentScaled(roundByWidth: 5), position: CGPoint.zero, zPosition: 3)
    
    let backBtnContent = Sprite(imageNamed: "back", size: CGSize.withPercentScaled(roundByWidth: 5), position: CGPoint.zero, zPosition: 3)
    
    let menuBtnContent = Sprite(imageNamed: "menu", size: CGSize.withPercentScaled(roundByWidth: 5), position: CGPoint.zero, zPosition: 3)
    
    let playBtnContent = Sprite(imageNamed: "play", size: CGSize.withPercentScaled(roundByWidth: 11.5), position: CGPoint(x: 10, y: 0), zPosition: 3)
    
    let replayBtnContent = Sprite(imageNamed: "replay", size: CGSize.withPercentScaled(roundByWidth: 5), position: CGPoint.zero, zPosition: 3)
    
    let howtoplayBtnContent = Sprite(imageNamed: "howtoplay", size: CGSize.withPercentScaled(roundByWidth: 8), position: CGPoint.zero, zPosition: 3)
    
    override func didMove(to view: SKView) {
        soundBtn.setSwitchState(UserDefaults.standard.bool(forKey: SoundConfig.playSounds))
        soundBtn.delegate = self
        
//        homeBtn.addChild(homeBtnContent)
//
//        playBtn.addChild(playBtnContent)
//
//        replayBtn.addChild(replayBtnContent)
//
//        howToPlayBtn.addChild(howtoplayBtnContent)
//
//        backBtn.addChild(backBtnContent)
//
//        menuBtn.addChild(menuBtnContent)
        
    }
    
    func changeToggleButtonState(_ sender: ToggleButton) {
        Sounds.sharedInstance().changeSoundAndMusicState()
    }
    
    func addChild(_ button: Button) {
        buttons.append(button)
        super.addChild(button)
    }
    
    
    
    func addChild(_ nodes: [SKNode]) {
        for (_, value) in nodes.enumerated() {
            if value.isKind(of: Button.self) {
                addChild(value as! Button)
            }
            else {
                addChild(value)
            }
        }
    }
    
    func addChildScaleAnimation(_ nodes: [SKNode], duration: TimeInterval) {
        for (_, value) in nodes.enumerated() {
            if value.isKind(of: Button.self) {
                addChild(value as! Button)
            }
            else {
                addChild(value)
            }
            value.setScale(0)
            value.run(.scale(to: 1, duration: duration))
        }
    }
    
    func addChildScaleAnimation(_ node: SKNode, duration: TimeInterval) {
        addChild(node)
        node.setScale(0)
        node.run(.scale(to: 1, duration: duration))
    }
    
    
    /**
     We can call this func for change all buttons state on scene to simple.
     */
    func touchUpAllButtons() {
        
        for button in buttons { button.touchUp()}
    }
    
    func touchDownButtons(atLocation location: CGPoint) {
        
        for (_ ,button) in buttons.enumerated() {
            button.touchDown(ifInLocation: location)
        }
    }
    
    func changeSceneTo(scene : SKScene) {
        
        Sounds.sharedInstance().sceneForPlayingSounds = scene
        
        //Show new scene
        view?.presentScene(scene)
        
        //Clean old scene after show new
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func changeSceneTo(scene : SKScene, withTransition transition: SKTransition) {
        
        Sounds.sharedInstance().sceneForPlayingSounds = scene
        
        // Show new scene
        view?.presentScene(scene, transition: transition)
        
        // Clean old scene after show new
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(cleanOldScene), userInfo: nil, repeats: false)
    }
    
    func showLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "showLeaderboard"), object: nil)
    }
    
    func getLeaderboard() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "getLeaderboard"), object: nil)
    }
    
    func submitScore() {
        NotificationCenter.default.post(name: Notification.Name(rawValue: "submitScore"), object: nil)
    }
    
    func setSoundBtn(_ size:CGSize, _ position:CGPoint) {
        soundBtn.size = size
        soundBtn.position = position
    }
    
    func setRankingBtn(_ size:CGSize, _ position:CGPoint) {
        rankingBtn.size = size
        rankingBtn.position = position
    }
    
    func setHomeBtn(_ size:CGSize, _ position:CGPoint) {
        homeBtn.size = size
        homeBtn.position = position
    }
    
    func setScoreLbl(_ fontSize:CGFloat, _ color:UIColor, _ position:CGPoint) {
        scoreLbl.fontSize = fontSize
        scoreLbl.color = color
        scoreLbl.position = position
    }
    
    func setBestLbl(_ fontSize:CGFloat, _ color:UIColor, _ position:CGPoint) {
        bestLbl.fontSize = fontSize
        bestLbl.color = color
        bestLbl.position = position
    }
    
    func setScore() {
        score = UserDefaults.standard.integer(forKey: GameConfig.currentScore)
        best = UserDefaults.standard.integer(forKey: GameConfig.bestScore)
        
        scoreLbl.text = "Score: " + String(score)
        bestLbl.text = "Best Score: " + String(best)
    }
    
    
    
    /**
     This function helped to clean old scene from something nodes and actions
     */
    @objc func cleanOldScene() {
        removeAllChildren()
        removeAllActions()
        removeFromParent()
        print("GlobalScene: Old scene is been cleaned")
    }
}
