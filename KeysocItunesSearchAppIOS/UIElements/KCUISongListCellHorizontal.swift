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
}
