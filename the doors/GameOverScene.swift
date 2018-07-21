//
//  GameOverScene.swift
//  the doors
//
//  Created by Yoshua Elmaryono on 18/07/18.
//  Copyright © 2018 Yoshua Elmaryono. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameOverScene: SKScene {
    private var impendingDeath_SFXArray: [AVAudioPlayer] = []
    private var death_SFXArray: [AVAudioPlayer] = []
    
    var gameController: GameController?
    
    override func didMove(to view: SKView) {
        loadAndPlay_impendingDeathSFXS()
        loadDeathSFXS()
        
        let deathDelay = 3.0
        Timer.scheduledTimer(withTimeInterval: deathDelay, repeats: false) { (timer) in
            self.playDeathSFXS()
        }
    }
    
    func loadAndPlay_impendingDeathSFXS(){
        do {
            let objectBroken_SFXData = NSDataAsset(name: "objectBrokenSFX")!.data
            let objectBrokenSFX = try AVAudioPlayer(data: objectBroken_SFXData, fileTypeHint: AVFileType.mp3.rawValue)
            
            let heartBeat_SFXData = NSDataAsset(name: "heartBeatSFX")!.data
            let heartBeatSFX = try AVAudioPlayer(data: heartBeat_SFXData, fileTypeHint: AVFileType.mp3.rawValue)
            
            impendingDeath_SFXArray = [objectBrokenSFX, heartBeatSFX]
            impendingDeath_SFXArray.forEach { (sfx) in sfx.play() }
        } catch {
            print(error.localizedDescription)
        }
    }
    func loadDeathSFXS(){
        do {
            let deathScream_SFXData = NSDataAsset(name: "deathScreamSFX")!.data
            let deathScreamSFX = try AVAudioPlayer(data: deathScream_SFXData, fileTypeHint: AVFileType.mp3.rawValue)
            
            let intro_SFXData = NSDataAsset(name: "introSFX")!.data
            let introSFX = try AVAudioPlayer(data: intro_SFXData, fileTypeHint: AVFileType.mp3.rawValue)
            
            death_SFXArray = [deathScreamSFX, introSFX]
        } catch {
            print(error.localizedDescription)
        }
    }
    func playDeathSFXS(){
        impendingDeath_SFXArray.forEach { (sfx) in
            if sfx.isPlaying {
                sfx.setVolume(0, fadeDuration: 0.5)
            }
        }
        
        death_SFXArray.forEach { (sfx) in sfx.play() }
        gameController?.stopBGM()
    }
}
