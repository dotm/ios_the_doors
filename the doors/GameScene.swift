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
    private var cameraNode: SKCameraNode!
    private var blackCover: SKShapeNode!
    
    var gameController: GameController?
    
    override func didMove(to view: SKView) {
        leftDoor = self.childNode(withName: "leftDoor") as! SKSpriteNode
        rightDoor = self.childNode(withName: "rightDoor") as! SKSpriteNode
        centerDoor = self.childNode(withName: "centerDoor") as! SKSpriteNode
        
        blackCover = self.childNode(withName: "blackCover") as! SKShapeNode
        
        cameraNode = SKCameraNode()
        cameraNode.position = CGPoint(x: 0, y: 0)
        self.addChild(cameraNode)
        self.camera = cameraNode
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
        enterDoor(leftDoor)
        gameController?.guessLeftDoor()
    }
    private func touchCenterDoor(){
        enterDoor(centerDoor)
        gameController?.guessCenterDoor()
    }
    private func touchRightDoor(){
        enterDoor(rightDoor)
        gameController?.guessRightDoor()
    }
    private func enterDoor(_ door: SKNode, duration: TimeInterval = 2.0){
        let zoomInAction = SKAction.scale(to: 0.2, duration: duration)
        let moveCenter_toDoor = SKAction.move(to: door.position, duration: duration)
        
        let enterDoorAnimation = SKAction.group([zoomInAction, moveCenter_toDoor])
        let cover = SKAction.fadeAlpha(to: 1, duration: duration)
        
        blackCover.run(cover)
        cameraNode.run(enterDoorAnimation) {
            self.resetCameraPosition()
        }
    }
    private func resetCameraPosition(){
        let duration = 0.1
        let zoomOutAction = SKAction.scale(to: 1, duration: duration)
        let centerPosition = CGPoint(x: 0, y: 0)
        let resetCenter = SKAction.move(to: centerPosition, duration: duration)
        
        let resetCameraAnimation = SKAction.group([zoomOutAction, resetCenter])
        let uncover = SKAction.fadeAlpha(to: 0, duration: 1)
        
        blackCover.run(uncover)
        cameraNode.run(resetCameraAnimation)
    }
}
