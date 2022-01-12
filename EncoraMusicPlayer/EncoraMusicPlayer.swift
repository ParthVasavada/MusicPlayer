//
//  EncoraMusicPlayer.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 11/04/21.
//

import Foundation
import AVFoundation

class EncoraMusicPlayer {
    
    static let shared = EncoraMusicPlayer()
    
    private(set) lazy var player = AVPlayer()
    
    private init() {}
    
    func initializePlayer(with url: URL) {
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
    }
    
    /// To pause the song.
    func pause(){
        player.pause()
    }
    
    /// To pay the song.
    func play() {
        player.play()
    }
}
