//
//  KCUITableSectionHeaderViewCell.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 16/9/2023.
//

import UIKit

class KCUITableSectionHeaderViewCell : UITableViewHeaderFooterView {
    
    var label: UILabel?
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configure()
    }
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    private func configure() {
        if self.label == nil {
            let label = UILabel()

            label.numberOfLines = 0

            label.font = UIFont.systemFont(ofSize: 16, weight: .medium) // Set the font size and weight
            label.textColor = UIColor.black // Set the text color
            label.translatesAutoresizingMaskIntoConstraints = false

            addSubview(label)

            // Add constraints to center the label vertically and horizontally in the header view
            NSLayoutConstraint.activate([
                label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
                label.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
                label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 10),
                label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0),
            ])

            self.label = label
        }
    }
}
