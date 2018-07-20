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
    }
    func startRound(_ round: Int){
        let initialGuess = 5
        let totalGuesses: Int = {
            switch round {
            case 0...1: return initialGuess
            case 2...5: return initialGuess + 2
            default: return initialGuess + 5
            }
        }()
        fill_rightGuesses(totalGuesses: totalGuesses)
        
        goTo_startScene()
        
        var delay: Double {
            switch round {
            case 0...5: return 5.0
            case 5...10: return 4.0
            default: return 3.0
            }
        }
        goTo_gameScene(delay: delay)
    }
    func fill_rightGuesses(totalGuesses: Int){
        correctGuesses = []
        for _ in 0..<totalGuesses {
            let door = DoorGuess.randomGuess()
            correctGuesses.append(door)
        }
    }
    func goTo_startScene(){
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let filename = "GameStartScene"
            guard let scene = GameStartScene(fileNamed: filename) else {
                fatalError("\(filename) not found!")
            }
            
            scene.scaleMode = .aspectFill   // Set the scale mode to scale to fit the window
            
            scene.gameController = self
            scene.hints = correctGuesses
            
            let revealScene = SKTransition.reveal(with: .up, duration: 1)
            view.presentScene(scene, transition: revealScene)
            
            view.ignoresSiblingOrder = true
        }
    }
    func goTo_gameScene(delay: Double){
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            self.goTo_gameScene()
        }
    }
    func goTo_gameScene(){
        playerGuesses.removeAll()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            let filename = "GameScene"
            guard let scene = GameScene(fileNamed: filename) else {
                fatalError("\(filename) not found!")
            }
            
            scene.scaleMode = .aspectFill   // Set the scale mode to scale to fit the window
            scene.gameController = self
            
            let revealScene = SKTransition.reveal(with: .up, duration: 1)
            view.presentScene(scene, transition: revealScene)
            
            view.ignoresSiblingOrder = true
        }
    }
    func goTo_gameOverScene(){
        playerGuesses.removeAll()
        
        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameOverScene.sks'
            let filename = "GameOverScene"
            guard let scene = GameOverScene(fileNamed: filename) else {
                fatalError("\(filename) not found!")
            }

            scene.scaleMode = .aspectFill   // Set the scale mode to scale to fit the window
            scene.gameController = self
            
            let revealScene = SKTransition.reveal(with: .down, duration: 1)
            view.presentScene(scene, transition: revealScene)
            
            view.ignoresSiblingOrder = true
        }
    }
    func gameOver(){
        print("Game Over")
        goTo_gameOverScene()
        //go to game over scene
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
        if(!playerGuesses_areCorrect()){
            gameOver()
        }
        
        let allGuesses_areCorrect = playerGuesses == correctGuesses
        if(allGuesses_areCorrect){
            round += 1
            startRound(round)
        }
    }
    func playerGuesses_areCorrect() -> Bool{
        for i in 0..<playerGuesses.count {
            if playerGuesses[i] != correctGuesses[i] {
                return false
            }
        }
        return true
    }
}

