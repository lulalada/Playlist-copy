//
//  SongCell.swift
//  Playlist
//
//  Created by Alua Sayabayeva on 2023-03-13.
//

import UIKit

class SongCell: UITableViewCell {
    
    @IBOutlet weak var coverImage: UIImageView!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var songLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
