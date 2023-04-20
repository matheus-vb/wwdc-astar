//
//  PlaySound.swift
//  AStar
//
//  Created by matheusvb on 19/04/23.
//

import Foundation
import AVFoundation
var player: AVAudioPlayer = AVAudioPlayer()
var backgroundPlayer: AVAudioPlayer = AVAudioPlayer()

class SoundPlayer {
    //var playerEffects: AVAudioPlayer = AVAudioPlayer()
    
    func playSound(name: String, type: String) {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                player.play()
            } catch {
                print("ERRO: \(error)")
            }
        }
    }
    
    func playBackgroundSound(name: String, type: String) {
        if let path = Bundle.main.path(forResource: name, ofType: type) {
            do {
                backgroundPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                backgroundPlayer.numberOfLoops = -1
                backgroundPlayer.volume = 0.5
                backgroundPlayer.play()
            } catch {
                print("ERRO: \(error)")
            }
        }
    }
}
