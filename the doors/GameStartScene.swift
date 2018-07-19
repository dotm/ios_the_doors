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
    }
}
