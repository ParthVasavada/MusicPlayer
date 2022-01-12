//
//  SongTableViewCell.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 09/04/21.
//

import UIKit

class SongTableViewCell: UITableViewCell {

    @IBOutlet private weak var songImageView: UIImageView!
    
    @IBOutlet private weak var songTitleLabel: UILabel! {
        didSet {
            self.songTitleLabel.textColor = .appThemeColor
        }
    }
    
    static let identifier = "SongTableViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setSongTitle(title: String) {
        DispatchQueue.main.async {
            self.songTitleLabel.text = title
        }
        
    }
    
    func setSongImage(image: UIImage) {
        DispatchQueue.main.async {
            self.songImageView.image = image
        }
    }
}
