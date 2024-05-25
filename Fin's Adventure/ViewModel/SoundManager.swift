//
//  File.swift
//  
//
//  Created by Afrah Saleh on 11/08/1445 AH.
//

import Foundation
import SpriteKit
import AVFoundation


class SoundManager {
    static let shared = SoundManager()
       
       private var backgroundMusicPlayer: AVPlayer?
       private var nonLoopingMusicPlayer: AVPlayer?
       private var soundEffectPlayers: [String: AVAudioPlayer] = [:]

    // Setup and play background music
    func setupBackgroundMusic(soundName: String, withExtension ext: String) {
        guard let musicURL = Bundle.main.url(forResource: soundName, withExtension: ext) else {
            print("Failed to load the music file \(soundName).")
            return
        }
        
        let playerItem = AVPlayerItem(url: musicURL)
        backgroundMusicPlayer = AVPlayer(playerItem: playerItem)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerItemDidPlayToEndTime),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )
        
        backgroundMusicPlayer?.play()
    }

    @objc private func playerItemDidPlayToEndTime() {
        backgroundMusicPlayer?.seek(to: CMTime.zero)
        backgroundMusicPlayer?.play()
    }

    func stopBackgroundMusic() {
        backgroundMusicPlayer?.pause()
        if let playerItem = backgroundMusicPlayer?.currentItem {
            NotificationCenter.default.removeObserver(self, name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        }
        backgroundMusicPlayer = nil
    }

    func playSoundEffect(soundName: String, withExtension ext: String) {
        let key = "\(soundName).\(ext)"
        if let player = soundEffectPlayers[key] {
            // Restart the sound from the beginning
            player.currentTime = 0
            player.play()
        } else {
            // Create the player and start playing the sound
            if let player = setupSoundEffect(soundName: soundName, withExtension: ext) {
                soundEffectPlayers[key] = player
                player.play()
            }
        }
    }

    
    // Setup a sound effect
    private func setupSoundEffect(soundName: String, withExtension ext: String) -> AVAudioPlayer? {
        guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: ext) else {
            print("Could not load sound file: \(soundName)")
            return nil
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: soundURL)
            player.prepareToPlay()
            return player
        } catch {
            print("Could not create audio player: \(error)")
            return nil
        }
    }
    
    func playNonLoopingSound(soundName: String, withExtension ext: String) {
           stopNonLoopingSound()

           guard let soundURL = Bundle.main.url(forResource: soundName, withExtension: ext) else {
               print("Failed to load the sound file \(soundName).")
               return
           }
           let playerItem = AVPlayerItem(url: soundURL)
           nonLoopingMusicPlayer = AVPlayer(playerItem: playerItem)
           nonLoopingMusicPlayer?.play()
           
       }
       
       func stopNonLoopingSound() {
           nonLoopingMusicPlayer?.pause()
           nonLoopingMusicPlayer = nil
       }

       func stopAllMusic() {
           stopBackgroundMusic()
           stopNonLoopingSound()
       }

    
}
