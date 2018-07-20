//
//  GameStartScene.swift
//  the doors
//
//  Created by Yoshua Elmaryono on 19/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameStartScene: SKScene {
    var hints: [DoorGuess]!
    var gameController: GameController?
    
    override func didMove(to view: SKView) {
        print(hints)
        for i in 0..<hints.count{
            addHintSprite(i)
        }
    }
    func addHintSprite(_ index: Int){
        let boxSideLength = 50.0
        let boxSize = CGSize(width: boxSideLength, height: boxSideLength)
        let box: SKSpriteNode = {
            switch hints[index] {
            case .left: return SKSpriteNode(color: .red, size: boxSize)
            case .center: return SKSpriteNode(color: .green, size: boxSize)
            case .right: return SKSpriteNode(color: .blue, size: boxSize)
            }
        }()
        
        let median = getMedianPosition(array: hints)
        let xPosition = ((Double(index) - median) * 60) + (boxSideLength / 2)
        box.position = CGPoint(x: xPosition, y: 0)
        
        box.name = "box_1"
        addChild(box)
    }
    func getMedianPosition<T> (array: Array<T>) -> Double{
        return Double(array.count) / 2
    }
}
