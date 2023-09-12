//
//  KCUIRefreshControl.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUIRefreshControl: UIRefreshControl {
    var localizationKey: String = "generic_pull_to_refresh"
    
    override init() {
        super.init()
        initialize()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialize()
    }
    
    func initialize() {
        tintColor = UIColor.blue
        
        updateText()

        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name("LanguageDidChange"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func updateText() {
        if !localizationKey.isEmpty {
            attributedTitle = NSAttributedString(string: localizationKey.i18n())
        }
    }

    @objc private func languageDidChange() {
        updateText()
    }
}
