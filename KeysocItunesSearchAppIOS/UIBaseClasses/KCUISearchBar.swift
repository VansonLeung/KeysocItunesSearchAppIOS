//
//  KCUISearchBar.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUISearchBar: UISearchBar {
    var placeholderLocalizationKey: String = "generic_search_by_keywords"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
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
        if !placeholderLocalizationKey.isEmpty {
            placeholder = placeholderLocalizationKey.i18n()
        }
    }

    @objc private func languageDidChange() {
        updateText()
    }
}
