//
//  Sprite.swift
//  
//
//  Created by  on 3/21/19.
//  Copyright © 2019 . All rights reserved.
//

import SpriteKit

class Sprite: SKSpriteNode {
    
    init() {
        super.init(texture: SKTexture(imageNamed: "Images/img_null"), color: UIColor.clear, size: CGSize.zero)
    }
    
    //MARK: - Initialisation    
    init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(texture: SKTexture(imageNamed: "Images/" + imageNamed), color: UIColor.white, size: size)
        self.position = position
        self.zPosition = zPosition
        
        self.colorBlendFactor = 1.0
    }
    
    /**
     If your custom init function not can run compiler call this function
     */
    required init?(coder aDecoder: NSCoder) { fatalError("Sprite init(coder:) has not been implemented")}
    
    public func setRandomXPosition() {
        position = CGPoint(x: CGFloat(from: size.width / 2, to: VisibleRect.screenSize.width - size.width / 2), y: position.y)
    }
    
    private func setRandomYPosition() {
        position = CGPoint(x: position.x, y: CGFloat(from: size.height / 2, to: VisibleRect.screenSize.height - size.height / 2))
    }
    
    func compensationAngle(angle : CGFloat) -> CGFloat {
        return angle - CGFloat.pi/2
    }
    
    func betaAngle(point0 : CGPoint, point1 : CGPoint) -> CGFloat {
        return CGFloat(atan2f(Float(point1.y - point0.y), Float(point1.x - point0.x)))
    }
}
