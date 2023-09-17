//
//  String+i18n.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation

var i18nPending: [String] = []

/// Get the app current language.
///
/// - Parameters:
///   - bundle: Bundle
///
/// - Returns: "en", "zh-Hant", or "zh-Hans"
func GetCurrentLanguage(bundle : Bundle) -> String! {
    let language = UserDefaults.standard.string(forKey: "AppLanguage")
    if language != nil
    {
        return language
    }
    let _language = bundle.preferredLocalizations.first! as NSString
    if _language != "zh-Hant" &&  _language != "zh-Hans" &&  _language != "en"
    {
        return "en"
    }
    return _language as String
}

extension String {
    
    /// localizes the string according to the `AppLanguage` obtained via `GetCurrentLanguage(..)`
    ///
    /// - Returns: Localized string
    func i18n() -> String {
        
        var str = ""
        let language = GetCurrentLanguage(bundle: Bundle.main)
        if language != nil
        {
            let path = Bundle.main.path(forResource: language, ofType: "lproj")
            let bundle = Bundle(path: path!)
            str = bundle!.localizedString(forKey: self, value: nil, table: nil)
        }
        else
        {
            str = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "\(self)", comment: "i18n, \(self)")
            //        str = NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "**. \(self)", comment: "i18n, \(self)")
        }
        
        
        if str.hasPrefix("**. ")
        {
//            i18nPending.append(str)
        }
//        NSLog("i18n.....%@", str)
        return str
    }
}
