//
//  KCUILabel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUILabel : UILabel {

    /// Used for setting any specific localized text
    @IBInspectable var localizationKey: String = "" {
        didSet {
            updateText()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        updateText()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func updateText() {
        if !localizationKey.isEmpty {
            text = localizationKey.i18n()
        }
    }

    @objc private func languageDidChange() {
        updateText()
    }
}
