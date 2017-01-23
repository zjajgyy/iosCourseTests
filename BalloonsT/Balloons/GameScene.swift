//
//  GameScene.swift
//  Balloons
//
//  Created by Yanping Zhao on 11/28/16.
//  Copyright © 2016 Yanping Zhao. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    let blimpNode = MovingNode(imageNamed: "blimp.png")
    let pointsToMovePerSecond: Scalar = 100.0
    
    var lastUpdateTime: TimeInterval = 0

    override func didMove(to view: SKView) {
        /*
        let background = SKSpriteNode(imageNamed: "background")
        background.position = CGPoint(x:size.width/2, y:size.height/2)
        background.size = CGSize(width:size.width, height: size.height)
        
        let hills = SKSpriteNode(imageNamed: "hills1")
        hills.size = CGSize(width: size.width, height: 666)
        hills.position = CGPoint(x:size.width/2, y: hills.size.height/2)
        hills.zPosition = 2
        
        let tent = SKSpriteNode(imageNamed: "circus_tent")
        tent.size = CGSize(width: 1075, height: 500)
        tent.position = CGPoint(x:600, y: 300)
        tent.zPosition = 1
        
        addChild(background)
        addChild(hills)
        addChild(tent)*/
        
        setUpBlimpNode()
    }
    
    private func setUpBlimpNode() {
        blimpNode.name = "blimp"
        blimpNode.xScale = 0.5
        blimpNode.yScale = 0.5
        //blimpNode.zRotation = CGFloat(-1*M_PI)
        //blimpNode.color = UIColor.blue
        //blimpNode.colorBlendFactor = 0.5
        blimpNode.position = CGPoint(x: 100, y:size.height / 2)
        
        blimpNode.velocity = Vector(x: pointsToMovePerSecond, y: 0)
        
        addChild(blimpNode)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {
            return
        }
        
        let touchLocation = touch.location(in: self)
        
        moveToward(sprite: blimpNode, target: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        var interval: TimeInterval = 0
        if lastUpdateTime > 0 {
            interval = currentTime - lastUpdateTime
        }
        print("\(interval*1000) milliseconds since last update")
        
        boundsCheck(sprite: blimpNode)
        
        move(sprite: blimpNode,
             interval: interval)
        
        rotate(sprite: blimpNode,
               direction: blimpNode.velocity)
        
        lastUpdateTime = currentTime
    }
    
    func boundsCheck(sprite: MovingNode) {
        var bottomLeft = CGPoint(x: sprite.size.width / 2, y: sprite.size.width / 2)
        if let grassNode = childNode(withName: "grass") as? SKSpriteNode {
            bottomLeft.y += grassNode.size.height
        }
        
        let topRight = CGPoint(x: size.width - sprite.size.width / 2, y: size.height - sprite.size.width / 2)
        
        if sprite.position.x <= bottomLeft.x {
            sprite.velocity.x = -sprite.velocity.x
            sprite.position.x = bottomLeft.x
        }
        if sprite.position.x >= topRight.x {
            sprite.velocity.x = -sprite.velocity.x
            
            sprite.position.x = topRight.x
        }
        if sprite.position.y <= bottomLeft.y {
            sprite.velocity.y = -sprite.velocity.y
            
            sprite.position.y = bottomLeft.y
        }
        if sprite.position.y >= topRight.y {
            sprite.velocity.y = -sprite.velocity.y
            
            sprite.position.y = topRight.y
        }
    }
    
    func moveToward(sprite: MovingNode,
                    target: CGPoint) {
        let offset = Vector(x: target.x - sprite.position.x, y: target.y - sprite.position.y)
        
        sprite.velocity = offset.normalized() * pointsToMovePerSecond
    }
    
    func move(sprite: MovingNode,
              interval: TimeInterval) {
        let amountToMoveX = sprite.velocity.x * CGFloat(interval)
        let amountToMoveY = sprite.velocity.y * CGFloat(interval)

        sprite.position = CGPoint(
            x: sprite.position.x + amountToMoveX,
            y: sprite.position.y + amountToMoveY)
        
        print("amountToMoveX: \(amountToMoveX) sprint position: \(sprite.position)")
    }
    
    func rotate(sprite: MovingNode,
                direction: Vector) {
        sprite.zRotation = CGFloat(
            atan2(direction.y, direction.x))
        
        print("zRotation: \(sprite.zRotation)")
    }
}
