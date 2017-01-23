//
//  GameViewController.swift
//  Balloons
//
//  Created by Yanping Zhao on 11/28/16.
//  Copyright © 2016 Yanping Zhao. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameSceneGame") as? GameSceneGame {
            //let scene = GameScene(size:CGSize(width: 2048, height: 1536))
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            //scene.physicsWorld.gravity = CGVector(dx: 0.0, dy: 9.8)
            scene.physicsWorld.contactDelegate = scene
            
            // Present the scene
            view.presentScene(scene)
            
            // true: a node draws its child nodes that share the same zPosition in randome order
            // false: a node draws its child nodes with the same zPosition in the order they were added to their parent.
            view.ignoresSiblingOrder = true
            
            //view.showsPhysics = true
            view.showsFPS = true
            view.showsNodeCount = true
        }
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
