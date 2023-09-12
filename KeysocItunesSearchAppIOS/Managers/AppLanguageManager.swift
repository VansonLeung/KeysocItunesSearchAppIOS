//
//  AppLanguageManager.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation


class AppLanguageManager {
    static let shared = AppLanguageManager()

    private let kAppLanguageKey = "AppLanguage"

    var currentLanguage: String {
        get {
            return (UserDefaults.standard.string(forKey: kAppLanguageKey)) ?? "en" // Default to English
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kAppLanguageKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    func changeAppLanguage(language: String) {
        AppLanguageManager.shared.currentLanguage = language
        NotificationCenter.default.post(name: NSNotification.Name("LanguageDidChange"), object: nil)
    }
}
