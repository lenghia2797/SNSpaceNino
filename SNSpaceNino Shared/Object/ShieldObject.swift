//
//  ShieldObject.swift
//  PPColorGA iOS
//
//  Created by hehehe on 3/5/22.
//

import Foundation
import SpriteKit

class ShieldObject : Sprite {
    var sprites = [Sprite]()
    let rotateNode = SKSpriteNode()
    let node = SKSpriteNode()
    var type = "1"
    
    override init(imageNamed: String, size: CGSize, position: CGPoint, zPosition: CGFloat) {
        super.init(imageNamed: imageNamed, size: size, position: position, zPosition: zPosition)
        
        addChild(rotateNode)
        
        addChild(node)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSprite(imageNamed: String, size: CGSize, zPosition: CGFloat) {
        let sprite = Sprite(imageNamed: imageNamed, size: size, position: CGPoint(x: 0, y: 100), zPosition: zPosition)
        sprite.name = "1"
        let sprite2 = Sprite(imageNamed: imageNamed, size: size, position: CGPoint(x: 0, y: -100), zPosition: zPosition)
        sprite2.name = "2"
        
        sprites.append(sprite)
        sprites.append(sprite2)
        if type == "1" {
            rotateNode.run(.repeatForever(.rotate(byAngle: .pi, duration: 2)))
            addSpriteInRotateNode(sprite: sprite)
            addSpriteInRotateNode(sprite: sprite2)
        } else if type == "2" {
            rotateNode.run(.repeatForever(.rotate(byAngle: -1 * .pi, duration: 2)))
            addSpriteInRotateNode(sprite: sprite)
            addSpriteInRotateNode(sprite: sprite2)
        } else if type == "3" {
            addSpriteInNode(sprite: sprite)
            addSpriteInNode(sprite: sprite2)
        } else if type == "4" {
            node.zRotation = .pi/2
            addSpriteInNode(sprite: sprite)
            addSpriteInNode(sprite: sprite2)
        }
        
    }
    
    func addSpriteInRotateNode(sprite: Sprite) {
        rotateNode.addChild(sprite)
    }
    
    func addSpriteInNode(sprite: Sprite) {
        node.addChild(sprite)
        if sprite.name == "1" {
            sprite.run(.repeatForever(.sequence([
                .moveBy(x: 0, y: -50, duration: 1),
                .moveBy(x: 0, y: 50, duration: 1)
            ])))
        } else {
            sprite.run(.repeatForever(.sequence([
                .moveBy(x: 0, y: 50, duration: 1),
                .moveBy(x: 0, y: -50, duration: 1)
            ])))
        }
    }
}
