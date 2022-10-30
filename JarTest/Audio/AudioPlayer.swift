//
//  AudioPlayer.swift
//  JarTest
//
//  Created by Oleh Titov on 17.08.2022.
//

import Foundation
import AVFoundation

class AudioPlayer : ObservableObject {
    var player = AVAudioPlayer()
    
    let volume: Float
    
    init(name: String, withExtension: String, volume: Float = 1) {
        self.volume = volume
        if let url = Bundle.main.url(forResource: name, withExtension: withExtension) {
            print("success with \(name)")
            do {
                player = try AVAudioPlayer(contentsOf: url)
                player.prepareToPlay()
                player.setVolume(volume, fadeDuration: 0)
            }catch {
                print("error playing file \(error.localizedDescription)")
            }
        }
    }
    
    func play() {
        player.setVolume(volume, fadeDuration: 0)
        player.play()
    }
    
    func pauseSmoothly(duration: Double) {
        player.setVolume(0, fadeDuration: duration)
        player.pause()
    }
    
}
