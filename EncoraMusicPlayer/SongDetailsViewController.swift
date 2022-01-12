//
//  SongDetailsViewController.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 09/04/21.
//

import UIKit
import AVFoundation

class SongDetailsViewController: UIViewController {

    static let storyboardID = "SongDetailsViewController"

    
    @IBOutlet private weak var songImageView: UIImageView!
    
    @IBOutlet private weak var songTitleLabel: UILabel! {
        didSet {
            self.songTitleLabel.textColor = .appThemeColor
        }
    }

    @IBOutlet private weak var artistLabel: UILabel! {
        didSet {
        self.artistLabel.textColor = .appThemeColor
        }
    }
    
    @IBOutlet private weak var songProgressBar: UIProgressView! {
        didSet{
            self.songProgressBar.tintColor = .appThemeColor
            self.songProgress.progress = 0.0
        }
    }
    
    @IBOutlet private weak var songPlayPauseButton: UIButton! {
        didSet {
            self.songPlayPauseButton.tintColor = .appThemeColor
        }
    }
    
    
    @IBOutlet weak var songProgress: UIProgressView!
    
    private lazy var musicPlayer = EncoraMusicPlayer.shared
    
    private lazy var progressTimer = Timer()
    
    private var songToggle = false {
        didSet {
            if self.songToggle {
                self.musicPlayer.play()
            } else {
                self.musicPlayer.pause()
            }
        }
    }
    
    var selectedSong: Song?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.musicPlayer.pause()
    }
    
    //MARK:- Private Methods
    private func setupUI() {
        guard let songImage = self.selectedSong?.image,
              let songTitle = self.selectedSong?.title,
              let artist = self.selectedSong?.artist,
              let songURLString = self.selectedSong?.songURL,
              let songURL = URL(string: songURLString)else { return }
        self.songImageView.image = songImage
        self.songTitleLabel.text = "Title: \(String(describing: songTitle))"
        self.artistLabel.text = "Artist: \(String(describing: artist))"
        self.musicPlayer.initializePlayer(with: songURL)
    }
    
    private func setupProgressCheckTimer() {
        self.progressTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateSongProgress), userInfo: nil, repeats: true)
        
    }
    
    @objc private func updateSongProgress() {
        let currentTime = CMTimeGetSeconds(self.musicPlayer.player.currentTime())
        guard let totalTime = self.musicPlayer.player.currentItem?.asset.duration.seconds else { return }
        guard currentTime < totalTime else {
            self.progressTimer.invalidate()
            
            return }
        self.songProgress.progress = Float(currentTime/totalTime)
        self.songProgress.setProgress(self.songProgress.progress, animated: true)
    }
    
    @IBAction private func playPausePlayer(_ sender: UIButton) {
        self.songToggle = !self.songToggle
        sender.setTitle(self.songToggle ? "||" : "▶", for: .normal)
        if self.songToggle {
            self.setupProgressCheckTimer()
        } else {
            self.progressTimer.invalidate()
        }
    }
}
