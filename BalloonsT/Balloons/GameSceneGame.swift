//
//  GameSceneGame.swift
//  Balloons
//
//  Created by Yanping Zhao on 11/29/16.
//  Copyright © 2016 Yanping Zhao. All rights reserved.
//

import UIKit
import SpriteKit

class GameSceneGame: SKScene, SKPhysicsContactDelegate {
    
    struct Category {
        static let CATEGORY_NONE: UInt32 = 0x0
        static let CATEGORY_BALLOON: UInt32 = 0x1 << 0
        static let CATEGORY_CANNON: UInt32 = 0x1 << 1
        static let CATEGORY_GROUND: UInt32 = 0x1 << 2
        static let CATEGORY_BLIMP: UInt32 = 0x1 << 3
    }
    
    let blimpNode = SKSpriteNode(imageNamed: "blimp.png")
    var blimpMovePath = UIBezierPath()
    
    let hudLabel = SKLabelNode(fontNamed: "Chalkduster")
    
    var isTrackingCannon = false
    
    let balloonImages = ["blue", "heart-blue", "star-blue","green", "star-green", "heart-pink", "heart-red", "orange", "red", "star-gold", "star-pink", "star-red", "yellow"]
    
    var numberPops = 0
    var numberHits = 0
    
    override func didMove(to view: SKView) {
        
        //set up ground node
        let groundNode = childNode(withName: "//ground")
        groundNode?.physicsBody?.categoryBitMask = Category.CATEGORY_GROUND
        
        setupBlimp()
        
        setupCannons()
        
        setupHUD()
        
        blimpNode.run(moveForwardAction(), withKey: "TurnAndMoveForward")
    }
    
    func setupBlimp() {
        blimpNode.name = "blimp"
        //blimpNode.xScale = 0.7
        //blimpNode.yScale = 0.7
        blimpNode.position = CGPoint(x: blimpNode.size.width / 2 + 1200, y:self.frame.midY)
        
        blimpNode.physicsBody = SKPhysicsBody(rectangleOf: blimpNode.size)
        blimpNode.physicsBody?.affectedByGravity = false
        //blimpNode.physicsBody?.isDynamic = false
        
        blimpNode.physicsBody?.categoryBitMask = Category.CATEGORY_BLIMP
        blimpNode.physicsBody?.collisionBitMask = Category.CATEGORY_BALLOON
        blimpNode.physicsBody?.contactTestBitMask = Category.CATEGORY_BALLOON
        
        self.addChild(blimpNode)
        
        createBlimpMovePath()
        //moveBlimp()
    }
    
    func createBlimpMovePath()  {
        blimpMovePath.move(to: CGPoint(x: 0.0, y:0))
        for xOffset in 0...110 {
            blimpMovePath.addLine(to: CGPoint(x: 5 * xOffset, y:yOffsetForTime(xOffset)))
            //blimpMovePath.addLine(to: CGPoint(x: 5 * xOffset, y:0))
        }
    }
    
    func yOffsetForTime(_ index:Int)->Int {
        return Int(80 * sin(Double(index) * 0.1))
    }
    
    func moveForwardAction() -> SKAction {
        let pauseAction = SKAction.wait(forDuration: 0.2)
        let moveAction = SKAction.follow(blimpMovePath.cgPath, asOffset: true, orientToPath: false, speed: 80.0)
        
        return SKAction.repeatForever(SKAction.sequence([pauseAction, moveAction]))
    }
    
    func moveBackwardAction() -> SKAction {
        let pauseAction = SKAction.wait(forDuration: 0.05)
        let moveAction = SKAction.move(by: CGVector(dx: -100, dy: 0), duration: 0.5)
        
        return SKAction.sequence([SKAction.move(by: CGVector(dx: 0, dy: 150), duration: 0.5), SKAction.repeatForever(SKAction.sequence([pauseAction, moveAction]))])
    }
    
    func turnBackwardAction() -> SKAction {
        let pauseAction = SKAction.wait(forDuration: 0.2)
        let shrinkForwardAction = SKAction.scaleX(to: 0.05, duration: 0.25)
        let enlargeBackwardAction = SKAction.scaleX(to: -1.0, duration: 0.25)
        
        return SKAction.sequence([pauseAction, shrinkForwardAction, enlargeBackwardAction])
    }
    
    func turnForwardAction() -> SKAction {
        let pauseAction = SKAction.wait(forDuration: 0.2)
        let shrinkBackwardAction = SKAction.scaleX(to: -0.05, duration: 0.25)
        let enlargeForwardAction = SKAction.scaleX(to: 1.0, duration: 0.25)
        
        return SKAction.sequence([pauseAction, shrinkBackwardAction, enlargeForwardAction])
    }
    
    func moveBlimp() {
        /*
        let pauseAction = SKAction.wait(forDuration: 0.2)
        let moveForwardAction = SKAction.follow(blimpMovePath.cgPath, asOffset: true, orientToPath: false, speed: 80.0)
        
        
        let moveBackwardAction = moveForwardAction.reversed()
        
        
        let shrinkForwardAction = SKAction.scaleX(to: 0.05, duration: 0.25)
        let enlargeBackwardAction = SKAction.scaleX(to: -1.0, duration: 0.25)
        let turnBackwardAction = SKAction.sequence([shrinkForwardAction, enlargeBackwardAction])
        
        let shrinkBackwardAction = SKAction.scaleX(to: -0.05, duration: 0.25)
        let enlargeForwardAction = SKAction.scaleX(to: 1.0, duration: 0.25)
        let turnForwardAction = SKAction.sequence([shrinkBackwardAction, enlargeForwardAction])
        
        let blimpMoveAction = SKAction.sequence([pauseAction, moveForwardAction, pauseAction, turnBackwardAction, pauseAction, moveBackwardAction, pauseAction, turnForwardAction])
        
        blimpNode.run(SKAction.repeatForever(blimpMoveAction))*/
    }
    
    func boundsCheck() {
        let left = blimpNode.size.width / 2 + 10
        let right = size.width - blimpNode.size.width / 2 - 10
        
        if blimpNode.position.x <= left {
            blimpNode.position.x = left
            
            if blimpNode.action(forKey: "TurnAndMoveForward") == nil {
                blimpNode.removeAction(forKey: "TurnAndMoveBackward")
                blimpNode.run(SKAction.sequence([turnForwardAction(), moveForwardAction()]), withKey: "TurnAndMoveForward")
            }
        }
        
        if blimpNode.position.x >= right {
            blimpNode.position.x = right
            
            blimpNode.removeAction(forKey: "TurnAndMoveForward")
            if blimpNode.action(forKey: "TurnAndMoveBackward") == nil {
                blimpNode.run(SKAction.sequence([turnBackwardAction(), moveBackwardAction()]), withKey: "TurnAndMoveBackward")
            }
        }
    }
    
    // MARK: - Handling Touches
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //only one finger touch
        guard let touch = touches.first else {
            return
        }

        let touchLocation = touch.location(in: self)
        let touchedNode = self.atPoint(touchLocation)
        
        if touchedNode.name == "left_cannon" {
            //let radians = atan(location.y / location.x)
            isTrackingCannon = true
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if isTrackingCannon == true {
            guard let touch = touches.first else {
                return
            }
            let touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            
            if touchedNode.name == "left_cannon" {
                let radians = atan((touchLocation.y - touchedNode.position.y) / (touchLocation.x - touchedNode.position.x))
                
                touchedNode.zRotation =  radians - CGFloat(M_PI)
            }
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTrackingCannon = false
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent!) {
        isTrackingCannon = false
    }
    
    // MARK: - Cannons
    func setupCannons() {
        let leftCannonNode = self.childNode(withName: "//left_cannon")
        leftCannonNode?.physicsBody?.categoryBitMask = Category.CATEGORY_CANNON
        
        let rightCannonNode = self.childNode(withName: "//right_cannon")
        rightCannonNode?.physicsBody?.categoryBitMask = Category.CATEGORY_CANNON
        
        setBalloonActions(rightCannonNode!)
        setBalloonActions(leftCannonNode!)
    }
    
    // MARK: - Balloons
    
    func setBalloonActions(_ cannonNode: SKNode) {
        
        let waitAction = SKAction.wait(forDuration: 1.0, withRange: 0.05)
        let pauseAction = SKAction.wait(forDuration: 0.55, withRange: 0.05)
        let fireBalloonAction = SKAction.run({
            self.fireBalloon(cannonNode)
        })
        
        let fireCannonAction = SKAction.sequence([waitAction, fireBalloonAction, pauseAction, fireBalloonAction, pauseAction, fireBalloonAction, waitAction])
        
        cannonNode.run(SKAction.repeatForever(fireCannonAction))
    }
    
    func fireBalloon(_ cannonNode: SKNode) {
        let balloonNode = createBalloon(cannonNode)
        
        //imply the impulse to shoot the balloon
        let impulseMagnitude: CGFloat = 200.0
        
        var rotation: CGFloat = cannonNode.zRotation
        if rotation < 0 {
            rotation += CGFloat(M_PI)
        }
        
        let xComponent = cos(rotation) * impulseMagnitude
        let yComponent = sin(rotation) * impulseMagnitude
        let impulseVector = CGVector(dx: xComponent, dy: yComponent)
        
        balloonNode.physicsBody?.applyImpulse(impulseVector)
    }
    
    func createBalloon(_ cannonNode: SKNode) -> SKSpriteNode {
        let choice = Int(arc4random_uniform(UInt32(balloonImages.count)))
        let balloonImageName = "balloon-" + balloonImages[choice]
        
        let balloonNode = SKSpriteNode(imageNamed: balloonImageName)
        balloonNode.xScale = 2.0
        balloonNode.yScale = 2.0
        
        let mouthNode = cannonNode.childNode(withName: "mouth")
        
        balloonNode.position = mouthNode!.convert(CGPoint.zero, to: self)
        
        //configure physics boday
        let physicsBody = SKPhysicsBody(rectangleOf: balloonNode.size)
        physicsBody.linearDamping = 0.5
        physicsBody.mass = 0.1
        
        physicsBody.categoryBitMask = Category.CATEGORY_BALLOON
        physicsBody.collisionBitMask = Category.CATEGORY_BALLOON | Category.CATEGORY_GROUND | Category.CATEGORY_CANNON | Category.CATEGORY_BLIMP
        physicsBody.contactTestBitMask = Category.CATEGORY_BALLOON | Category.CATEGORY_GROUND | Category.CATEGORY_CANNON | Category.CATEGORY_BLIMP
        
        balloonNode.physicsBody = physicsBody
        
        self.addChild(balloonNode)
        
        return balloonNode
    }
    
    // MARK: - SKPhysicsWorldContactDelegate
    func didBegin(_ contact: SKPhysicsContact) {
        let collision = contact.bodyA.categoryBitMask
            | contact.bodyB.categoryBitMask
        
        if (collision == Category.CATEGORY_BALLOON) {//two ballons collide
            contact.bodyA.node!.run(balloonPopAction())
            
            numberPops += 1
        } else {
            if collision == Category.CATEGORY_BALLOON | Category.CATEGORY_BLIMP {
                numberHits += 1
            }
        }
    }
    
    func balloonPopAction() -> SKAction {
        let animationTextures = (1...4).map {
            SKTexture(imageNamed: "explode_0\($0)")
        }
        
        let popAction = SKAction.animate(with: animationTextures, timePerFrame: 1 / 30.0)
        let removeAction = SKAction.removeFromParent()
        
        return SKAction.sequence([popAction, removeAction])
    }
    
    // MARK: - Update
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        boundsCheck()
        
        updateHUD()
    }
    
    // MARK: - HUD
    func setupHUD() {
        hudLabel.fontSize = 64
        hudLabel.position = CGPoint(x: self.frame.maxX - 360 , y: self.frame.maxY - 80)
        hudLabel.name = "hudLabel"
        hudLabel.text = "Hits: 0  Pops: 0"
        hudLabel.fontColor = UIColor.black
        
        addChild(hudLabel)
    }
    
    func updateHUD() {
        hudLabel.text = "Hits: " + "\(numberHits)" + "  Pops: " + "\(numberPops)"
    }
}
