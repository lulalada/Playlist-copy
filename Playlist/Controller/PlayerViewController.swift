//
//  PlayerViewController.swift
//  Playlist
//
//  Created by Alua Sayabayeva on 2023-03-13.
//

import UIKit
import AVFoundation

class PlayerViewController: UIViewController {
    public var position: Int = 0
    public var songs: [Song] = []
    var isPlaying = true
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var timeLeftLabel: UILabel!
    @IBOutlet weak var timePassedLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var player: AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure(position: position)

        // Do any additional setup after loading the view.
    }
    

    
    func configure(position: Int) {
        //set player
        let song = songs[position]
        artistLabel.text = song.artistName
        titleLabel.text = song.name
        coverImage.image = UIImage(named: song.imageName)
        let url = Bundle.main.path(forResource: song.songName, ofType: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            guard let urlString = url else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: URL(string: urlString)!)
            
            guard let player = player else {
                return
            }
            
            player.play()
        } catch {
            print("error")
        }
        
        //set user interface elements
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let player = player {
            player.stop()
        }
    }
    
    @IBAction func playButton(_ sender: Any) {
        if isPlaying {
            player?.pause()
            isPlaying = false
        } else {
            player?.play()
            isPlaying = true
        }
    }
    @IBAction func goBackButton(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
        }
        
        if position > 0 {
            position = position - 1
        } else {
            position = songs.count - 1
        }
        configure(position: position)
        isPlaying = true
    }
    
    @IBAction func goForwardButton(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
        }
        
        if position < songs.count - 1 {
            position = position + 1
        } else {
            position = 0
        }
        configure(position: position)
        isPlaying = true
    }
}
