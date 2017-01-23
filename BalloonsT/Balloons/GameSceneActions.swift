//
//  import SpriteKit import GameplayKit  GameSceneActions.swift
//  Balloons
//
//  Created by Yanping Zhao on 11/29/16.
//  Copyright © 2016 Yanping Zhao. All rights reserved.
//

import SpriteKit
import GameplayKit

func random() -> CGFloat {
    return CGFloat(Float(arc4random()) / Float(UInt32.max))
}

func random(min: CGFloat, max: CGFloat) -> CGFloat {
    assert(min < max)
    return random() * (max - min) + min
}

struct Category {
    static let CATEGORY_NONE: UInt32 = 0x0
    static let CATEGORY_BALLOON: UInt32 = 0x1 << 0
    static let CATEGORY_BLIMP: UInt32 = 0x1 << 1
}

class GameSceneActions: SKScene, SKPhysicsContactDelegate {
    
    var blimpNode: SKSpriteNode?
    var balloonNode: SKSpriteNode?
    
    override func didMove(to view: SKView) {
        blimpNode = childNode(withName: "blimp") as? SKSpriteNode
        if blimpNode != nil {
            
            //self.physicsBody = SKPhysicsBody(edgeLoopFrom: CGRect(x: 50, y: 50, width: self.size.width - 100, height: size.height - 100))
            
            //blimpNode.physicsBody = SKPhysicsBody(circleOfRadius: max(blimpNode.size.width / 2, blimpNode.size.height / 2))
            blimpNode!.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: blimpNode!.size.width, height: blimpNode!.size.height))
            //blimpNode.physicsBody = SKPhysicsBody(texture: blimpNode.texture!, size: blimpNode.size)
            blimpNode!.physicsBody?.affectedByGravity = false
            blimpNode!.physicsBody?.categoryBitMask = Category.CATEGORY_BLIMP
            //blimpNode!.physicsBody?.collisionBitMask = Category.CATEGORY_NONE
            blimpNode!.physicsBody?.contactTestBitMask = Category.CATEGORY_BALLOON
            
            //blimpNode.physicsBody?.applyImpulse(CGVector(dx: random(min: 150, max: 300), dy: random(min: 200, max: 400)))
            Timer.scheduledTimer(timeInterval: 0.05, target: self, selector: #selector(applyForce), userInfo: nil, repeats: false)
        }
        
        balloonNode = childNode(withName: "balloon") as? SKSpriteNode
        if balloonNode != nil {
            balloonNode!.physicsBody = SKPhysicsBody(texture: balloonNode!.texture!, size: balloonNode!.size)
            balloonNode!.physicsBody?.affectedByGravity = false
            balloonNode!.physicsBody?.categoryBitMask = Category.CATEGORY_BALLOON
            //balloonNode!.physicsBody?.collisionBitMask = Category.CATEGORY_NONE
        }
    }
    
    func applyForce() {
        blimpNode?.physicsBody?.applyForce(CGVector(dx: 2000, dy: 0))
    }
    
    private func runActions(sprite: SKSpriteNode) {
        //let actionMoveTo = SKAction.move(to: CGPoint(x: size.width - sprite.size.width, y: sprite.position.y), duration: 2.5)
        //let actionMoveBy = SKAction.move(by: CGVector(dx: 200, dy: 200), duration: 2.5)
        //let actionRotate = SKAction.rotate(byAngle: CGFloat(M_PI) * 4, duration: 4.0)
        //let waitAction = SKAction.wait(forDuration: 1.0)
        //let turnAction = SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1.0)
        //let actionSpinForever = SKAction.repeatForever(turnAction)
        //let actionReversedMoveBy = actionMoveBy.reversed()
        //let actionRemove = SKAction.removeFromParent()
        
        //let sequenceAction = SKAction.sequence([actionRotate, actionMoveTo])
        //let groupAction = SKAction.group([actionRotate, actionMoveTo])
        //let compoundAction = SKAction.sequence([groupAction, SKAction.sequence([waitAction,turnAction])])
        
        //sprite.run(SKAction.sequence([actionMoveBy, actionReversedMoveBy, actionRemove]))
        
        //sprite.run(actionMoveTo)
    }
    
    // MARK: - SKPhysicsWorldContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask
            | contact.bodyB.categoryBitMask
        
        if collision == Category.CATEGORY_BALLOON | Category.CATEGORY_BLIMP {
            print("balloon collides with blimp")
        }
    }
}
