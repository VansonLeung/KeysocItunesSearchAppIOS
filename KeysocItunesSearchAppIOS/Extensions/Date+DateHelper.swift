//
//  Date+DateHelper.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation


extension Date {
    func parseAsString() -> String? {
        return DateHelper.dateFormat(date: self)
    }
    
    func parseAsStringLocalized() -> String? {
        return DateHelper.dateFormatLocalized(date: self)
    }
}
