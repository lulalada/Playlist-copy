//
//  ViewController.swift
//  Playlist
//
//  Created by Alua Sayabayeva on 2023-03-13.
//

import UIKit

class ViewController: UIViewController {
    

    @IBOutlet weak var table: UITableView!
    var songs = [Song]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSongs()
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "SongCell", bundle: nil), forCellReuseIdentifier: "ReusableCell")
        // Do any additional setup after loading the view.
    }
    
    func configureSongs() {
        songs.append(Song(name: "Young and Beautiful", artistName: "Lana Del rey", songName: "song1", imageName: "cover1"))
        songs.append(Song(name: "Dopamine", artistName: "BORNS", songName: "song2", imageName: "cover2"))
        songs.append(Song(name: "BLOW", artistName: "Ed Sheeran", songName: "song3", imageName: "cover3"))
        songs.append(Song(name: "Movie", artistName: "Tom Mische", songName: "song4", imageName: "cover4"))
        songs.append(Song(name: "Softcore", artistName: "The Neighbourhood", songName: "song5", imageName: "cover5"))
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
        tableView.deselectRow(at: indexPath, animated: true)
        
        //present the player
        let position = indexPath.row
        //songs
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "player") as? PlayerViewController else {
            return
        }
        vc.songs = songs
        vc.position = position
        present(vc, animated: true)
    }
}
