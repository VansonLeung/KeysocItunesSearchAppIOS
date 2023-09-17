//
//  KCUIBarButtonItem.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUIBarButtonItem : UIBarButtonItem {
    
    /// Used for setting localization keys for bar button title
    @IBInspectable var titleLocalizationKey: String = "" {
        didSet {
            updateText()
        }
    }
    
    
    /// The valid `init` function to replace the original `UIBarButtonItem -> init`
    ///
    /// Parameters:
    ///   - kcTitle: Button title
    ///   - style: Button style
    ///   - target: call target
    ///   - action: call target's selector
    convenience init(kcTitle title: String?, style: UIBarButtonItem.Style, target: Any?, action: Selector?)
    {
        self.init(title: title, style: style, target: target, action: action)
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
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
        if !titleLocalizationKey.isEmpty {
            title = titleLocalizationKey.i18n()
        }
    }

    @objc private func languageDidChange() {
        updateText()
    }
}
