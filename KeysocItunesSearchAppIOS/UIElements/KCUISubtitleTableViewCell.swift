//
//  KCUISubtitleTableViewCell.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 16/9/2023.
//

import UIKit

class KCUISubtitleTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
