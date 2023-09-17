//
//  AppLanguageManager.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift


class AppLanguageManager {
    
    static let shared = AppLanguageManager()

    private let kAppLanguageKey = "AppLanguage"

    static let kLanguageDidChangeKey = "LanguageDidChange"

    
    
    /// Get the app current language.
    ///
    /// - Parameters:
    ///   - bundle: Bundle
    ///
    /// - Returns: "en", "zh-Hant", or "zh-Hans"
    var currentLanguage: String {
        get {
            return (UserDefaults.standard.string(forKey: kAppLanguageKey)) ?? "en" // Default to English
        }
        set {
            UserDefaults.standard.set(newValue, forKey: kAppLanguageKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    
    /// Get the app current language for use in ITunes search API.
    ///
    /// - Returns: "en_us", "zh_hk", or "zh_cn"
    var currentKItunesSearchAPILanguage: String {
        let lang = currentLanguage
        if lang == "en" {
            return KCItunesParamLangManager.shared.LangListArray[0].val ?? "en_us"
        }
        if lang == "zh-Hant" {
            return KCItunesParamLangManager.shared.LangListArray[1].val ?? "en_us"
        }
        if lang == "zh-Hans" {
            return KCItunesParamLangManager.shared.LangListArray[2].val ?? "en_us"
        }
        return KCItunesParamLangManager.shared.LangListArray[0].val ?? "en_us"
    }
    
    
    /// Get the app current language.
    ///
    /// A notification `AppLanguageManager.kLanguageDidChangeKey` will be emitted upon a successful language change
    ///
    /// - Parameters:
    ///   - language: target language: "en", "zh-Hant", "zh-Hans"
    func changeAppLanguage(language: String) {
        AppLanguageManager.shared.currentLanguage = language
        NotificationCenter.default.post(name: NSNotification.Name(AppLanguageManager.kLanguageDidChangeKey), object: nil)
    }
}
