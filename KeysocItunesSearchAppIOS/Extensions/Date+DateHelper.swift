//
//  Date+DateHelper.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation


extension Date {
    
    /// Obtain formatted date `String` from itself
    func parseAsString() -> String? {
        return DateHelper.dateFormat(date: self)
    }
    
    /// Obtain formatted date and localized date `String` from itself
    func parseAsStringLocalized() -> String? {
        return DateHelper.dateFormatLocalized(date: self)
    }
}
