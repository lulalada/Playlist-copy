//
//  ViewController.swift
//  Playlist
//
//  Created by Alua Sayabayeva on 2023-03-13.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, MusicDelegate {
    

    @IBOutlet weak var table: UITableView!
    var player: AVAudioPlayer?
    var songs = [Song]()
    var position = 0
    var isPlaying = false
    
    @IBOutlet weak var miniPlayerView: UIView!
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var songLabel: UILabel!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        miniPlayerView.isHidden = true
        configureSongs()
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func playOrPause(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
            isPlaying = false
            playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        } else {
            player?.play()
            isPlaying = true
            playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func goForward(_ sender: UIButton) {
        if isPlaying {
            player?.pause()
        }
        
        if position < songs.count - 1 {
            position = position + 1
        } else {
            position = 0
        }
        let url = Bundle.main.path(forResource: songs[position].songName, ofType: "mp3")
        
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
            isPlaying = true
           
        } catch {
            print("error")
        }
        
        isPlaying = true
        playButton.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        coverImage.image = UIImage(named: songs[position].imageName)
        songLabel.text = songs[position].name
        
    }
    
    func configureSongs() {
        songs.append(Song(name: "Young and Beautiful", artistName: "Lana Del rey", songName: "song1", imageName: "cover1"))
        songs.append(Song(name: "Dopamine", artistName: "BORNS", songName: "song2", imageName: "cover2"))
        songs.append(Song(name: "BLOW", artistName: "Ed Sheeran", songName: "song3", imageName: "cover3"))
        songs.append(Song(name: "Movie", artistName: "Tom Mische", songName: "song4", imageName: "cover4"))
        songs.append(Song(name: "Softcore", artistName: "The Neighbourhood", songName: "song5", imageName: "cover5"))
    }
    
    
    func continueSong(position: Int, currentTime: TimeInterval, isPreviousPlaying: Bool) {
        miniPlayerView.isHidden = false
        coverImage.image = UIImage(named: songs[position].imageName)
        songLabel.text = songs[position].name
        
        let url = Bundle.main.path(forResource: songs[position].songName, ofType: "mp3")
        
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
            player.currentTime = currentTime
            if isPreviousPlaying {
                player.play()
                isPlaying = true
                
            } else {
                isPlaying = false
                playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
            }
           
        } catch {
            print("error")
        }
    
    }
    

}

//MARK: - UITableViewDelegate, UITableViewDataSource extensions
// UITableViewDataSource is responsible for populating the table
extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "ReusableCell", for: indexPath) as! SongCell
        cell.songLabel.text = songs[indexPath.row].name
        cell.authorLabel.text = songs[indexPath.row].artistName
        cell.coverImage.image = UIImage(named: songs[indexPath.row].imageName)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isPlaying = false
        player?.stop()
        position = indexPath.row
        performSegue(withIdentifier: "goToSong", sender: self)
        
      
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        guard let secondVC = segue.destination
          as? PlayerViewController else {return}
        secondVC.delegate = self

        if segue.identifier == "goToSong" {
            secondVC.songs = songs
            secondVC.position = position
        }
        
    }
}
