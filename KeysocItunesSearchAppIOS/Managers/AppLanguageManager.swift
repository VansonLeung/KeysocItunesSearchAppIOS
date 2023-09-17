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

    static let kLanguageDidChangeKey = "LanguageDidChange"

    var currentLanguage: String {
        get {
            return (UserDefaults.standard.string(forKey: kAppLanguageKey)) ?? "en" // Default to English
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kAppLanguageKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    var currentKItunesSearchAPILanguage: String {
        let lang = currentLanguage
        if lang == "en" {
            return "en_us"
        }
        if lang == "zh-Hant" {
            return "zh_hk"
        }
        if lang == "zh-Hans" {
            return "zh_cn"
        }
        return "en_us"
    }
    
    func changeAppLanguage(language: String) {
        AppLanguageManager.shared.currentLanguage = language
        NotificationCenter.default.post(name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
    }
}
