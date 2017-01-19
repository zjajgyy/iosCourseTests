//
//  GameScene.swift
//  Balloons
//
//  Created by zjajgyy on 2016/11/30.
//  Copyright © 2016年 zjajgyy. All rights reserved.
//

import SpriteKit
import SKAction
import GameplayKit

class GameScene: SKScene {
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    
    var blimpNode: SKSpriteNode?
    var lastUpdateTime: TimeInterval = 100.0
    static let pointsToMovePerSecond: CGFloat = 100.0
    var blimpVelocity = Vector(x: 0, y: 0) //速度，是个矢量

    override func didMove(to view: SKView) {
        blimpNode = childNode(withName: "//blimp") as! SKSpriteNode?
        blimpVelocity = Vector(x: GameScene.pointsToMovePerSecond, y: 0)
//        let backgroundNode = SKSpriteNode(imageNamed: "background")
//        backgroundNode.position = CGPoint(x: size.width/2, y:size.height/2)
//        backgroundNode.size = size
//        
//        let hillsNode = SKSpriteNode(imageNamed: "hills1")
//        hillsNode.size = CGSize(width: size.width, height: 666)
//        hillsNode.position = CGPoint(x: size.width/2, y: hillsNode.size.height/2)
//        hillsNode.zPosition = backgroundNode.zPosition+1
//        
//        
//        let tentNode = SKSpriteNode(imageNamed: "circus_tent")
//        tentNode.size = CGSize(width: size.width/6, height: size.height/6)
//        tentNode.position = CGPoint(x: tentNode.size.width/2+size.width/6, y: tentNode.size.height/2+size.height/8)
//        tentNode.zPosition = hillsNode.zPosition+1
//    
//        addChild(backgroundNode)
//        addChild(hillsNode)
//        addChild(tentNode)

        
//        // Get label node from scene and store it for use later
//        self.label = self.childNode(withName: "//helloLabel") as? SKLabelNode
//        if let label = self.label {
//            label.alpha = 0.0
//            label.run(SKAction.fadeIn(withDuration: 2.0))
//        }
//        
//        // Create shape node to use during mouse interaction
//        let w = (self.size.width + self.size.height) * 0.05
//        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
//        
//        if let spinnyNode = self.spinnyNode {
//            spinnyNode.lineWidth = 2.5
//            
//            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
//            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
//                                              SKAction.fadeOut(withDuration: 0.5),
//                                              SKAction.removeFromParent()]))
//        }
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if let label = self.label {
//            label.run(SKAction.init(named: "Pulse")!, withKey: "fadeInOut")
//        }
//        
//        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
        
        guard let touch = touches.first else {
            return
        }
        let touchLocation = touch.location(in: self)
        moveBlimp(toward: touchLocation)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        //for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //blimpNode?.position.x += 20
        
        //平滑移动
        var interval: TimeInterval = 0
        if lastUpdateTime > 0 {
            interval = currentTime - lastUpdateTime
        }
        print("\(interval*1000) milliseconds since last update")
        
        
        moveBlimp(interval: interval)
        checkBounds()
        retateBlimp(toward: blimpVelocity)
        
        
        
        lastUpdateTime = currentTime
    }
    
    func moveBlimp(toward: CGPoint){
        let offset = Vector(x: toward.x, y: toward.y) - Vector(x: (blimpNode?.position.x)!, y: (blimpNode?.position.y)!)
        
        blimpVelocity = offset.normalized() * GameScene.pointsToMovePerSecond
    }
    
    func moveBlimp(interval: TimeInterval) {
        let amountToMoveX = blimpVelocity.x * CGFloat(interval)
        let amountToMoveY = blimpVelocity.y * CGFloat(interval)
        
        blimpNode?.position = CGPoint(x: (blimpNode?.position.x)! + amountToMoveX, y: (blimpNode?.position.y)! + amountToMoveY)
        
        print("amountToMoveX: \(amountToMoveX) blimp position: \(blimpNode?.position)")
    }
    
    //旋转飞艇方向
    func retateBlimp(toward: Vector){
        blimpNode?.zRotation = CGFloat(atan2(toward.y, toward.x))
        
        
    }
    
    func checkBounds() {
        //可以加余量
        let bottomLeft = CGPoint(x: (blimpNode?.size.width)!/2, y: (blimpNode?.size.width)!/2)
        let topRight = CGPoint(x: size.width - (blimpNode?.size.width)!/2, y: size.height - (blimpNode?.size.width)!/2 )
        if (blimpNode?.position.x)! <= bottomLeft.x {
            blimpNode?.position.x = bottomLeft.x
        }//balabala,类似，思路一样
    }
}
