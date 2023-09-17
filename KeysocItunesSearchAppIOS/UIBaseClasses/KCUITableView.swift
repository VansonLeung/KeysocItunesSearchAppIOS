//
//  KCUITableView.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUITableView : UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func updateText() {
        reloadData()
    }

    @objc private func languageDidChange() {
        updateText()
    }
}

