//
//  KCUIViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUIViewController : UIViewController {
    public var looseNavigationController: UINavigationController?
    
    var getNavigationController: UINavigationController? {
        return navigationController ?? looseNavigationController
    }
    
    var overrideTitleLocalizationKey: String? = nil
    
    var titleLocalizationKey: String {
        get {
            return ""
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateText()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name("LanguageDidChange"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    private func updateText() {
        if let overrideTitleLocalizationKey = overrideTitleLocalizationKey,
           overrideTitleLocalizationKey != "" {
            title = overrideTitleLocalizationKey.i18n()
        }
        else if titleLocalizationKey != "" {
            title = titleLocalizationKey.i18n()
        }
    }

    @objc private func languageDidChange() {
        updateText()
    }
}

