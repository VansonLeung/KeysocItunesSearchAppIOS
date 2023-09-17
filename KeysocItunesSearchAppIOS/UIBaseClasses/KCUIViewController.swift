//
//  KCUIViewController.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import UIKit

class KCUIViewController : UIViewController {
    private var looseNavigationController: UINavigationController?
    
    var getNavigationController: UINavigationController? {
        return navigationController ?? looseNavigationController
    }
    
    /// Used for overriding navigation title localized text (first priority)
    var overrideTitleLocalizationKey: String? = nil {
        didSet {
            updateText()
        }
    }
    
    /// Used in custom KCUIViewController overriding navigation title localized text (second priority)
    ///
    /// Example usage:
    ///
    /// ```swift
    /// override var titleLocalizationKey: String {
    ///    return "New View Controller"
    /// }
    /// ```
    var titleLocalizationKey: String {
        get {
            return ""
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateText()
        NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
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

