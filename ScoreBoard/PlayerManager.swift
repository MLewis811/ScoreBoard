//
//  PlayerManager.swift
//  ScoreBoard
//
//  Created by Mike Lewis on 10/17/25.
//

import SwiftUI
import AVKit
import Combine

class PlayerManager: ObservableObject {
    let player = AVPlayer()
    
    func loadVideo(url: URL) {
        // Clean up the current item
        player.pause()
        player.replaceCurrentItem(with: nil)
        
        // Load new item
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
//        player.play()
    }
    
    deinit {
        player.pause()
        player.replaceCurrentItem(with: nil)
    }
}
