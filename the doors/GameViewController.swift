//
//  GameViewController.swift
//  the doors
//
//  Created by Yoshua Elmaryono on 18/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

enum DoorGuess: Int {
    case left, center, right
    
    static func randomGuess() -> DoorGuess {
        let possibleDoorGuess: UInt32 = 3  //because there are only 3 doors
        let value = Int(arc4random_uniform(possibleDoorGuess))
        let door = DoorGuess(rawValue: value)
        
        return door!
    }
}

class GameViewController: UIViewController {
    private var correctGuesses: [DoorGuess]! = []
    private var playerGuesses: [DoorGuess]! = []
    private var round = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        
        startRound(round)
        print(correctGuesses)
        goTo_gameScene()
    }
    func startRound(_ round: Int){
        let initialGuess = 5
        let addition_forEachRound = 2
        
        fill_rightGuesses(totalGuess: initialGuess + ((round - 1) * addition_forEachRound))
    }
    func fill_rightGuesses(totalGuess: Int){
        correctGuesses = []
        for _ in 0..<totalGuess {
            let door = DoorGuess.randomGuess()
            correctGuesses.append(door)
        }
    }
    func goTo_gameScene(){
        playerGuesses.removeAll()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            guard let scene = GameScene(fileNamed: "GameScene") else {
                fatalError("No GameScene found #860")
            }
            if true {
                scene.scaleMode = .aspectFill   // Set the scale mode to scale to fit the window
                scene.gameController = self
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
    }
    func gameOver(){
        print("Game Over")
    }

    //MARK: Display Settings
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
    override var prefersStatusBarHidden: Bool {
        return true
    }
}

protocol GameController {
    func guessLeftDoor()
    func guessRightDoor()
    func guessCenterDoor()
}
extension GameViewController: GameController {
    func guessLeftDoor() { guessDoor(.left) }
    func guessCenterDoor() { guessDoor(.center) }
    func guessRightDoor() { guessDoor(.right) }
    
    func guessDoor(_ door: DoorGuess){
        playerGuesses.append(door)
        if(playerGuesses != correctGuesses){
            gameOver()
        }
    }
}

