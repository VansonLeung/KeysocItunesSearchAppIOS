//
//  KCUISongListCellHorizontal.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit
import SDWebImage

class KCUISongListCellHorizontal: UITableViewCell {
    // Define UI elements for cell
    @IBOutlet weak var lblSongTitle: UILabel!
    @IBOutlet weak var lblSongDesc: UILabel!
    @IBOutlet weak var imgArtwork: UIImageView!
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        selectionStyle = .none
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
    }

    // Configure custom cell
    func configure(with viewModel: SongViewModel) {
        lblSongTitle.text = viewModel.title
        lblSongDesc.text = viewModel.desc

        if let imageUrl = viewModel.artworkUrl100 {
            // Use SDWebImage to load the image asynchronously
            imgArtwork.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholderImage"))
        } else {
            // Set a placeholder image if the URL is not available
            imgArtwork.image = UIImage(named: "placeholderImage")
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        
        if highlighted {
            // Apply your custom animation for cell highlighting
            UIView.animate(withDuration: 0.10) {
                self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }
        } else {
            // Apply your custom animation for cell unhighlighting
            UIView.animate(withDuration: 0.4) {
                self.transform = .identity
            }
        }
    }
}
