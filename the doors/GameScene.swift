//
//  GameScene.swift
//  the doors
//
//  Created by Yoshua Elmaryono on 18/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var leftDoor : SKSpriteNode!
    private var rightDoor : SKSpriteNode!
    private var centerDoor : SKSpriteNode!
    
    override func didMove(to view: SKView) {
        leftDoor = self.childNode(withName: "leftDoor") as! SKSpriteNode
        rightDoor = self.childNode(withName: "rightDoor") as! SKSpriteNode
        centerDoor = self.childNode(withName: "centerDoor") as! SKSpriteNode
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let position_inScene = touch.location(in: self)
        let touchedNodes = self.nodes(at: position_inScene)
        
        touchedNodes.forEach { (node) in
            let name = node.name
            switch name {
            case "leftDoor": touchLeftDoor()
            case "centerDoor": touchCenterDoor()
            case "rightDoor": touchRightDoor()
            default: break
            }
        }
    }
    
    private func touchLeftDoor(){
        print("touchLeftDoor")
    }
    private func touchCenterDoor(){
        print("touchCenterDoor")
    }
    private func touchRightDoor(){
        print("touchRightDoor")
    }
}
