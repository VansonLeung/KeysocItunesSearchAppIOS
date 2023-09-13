//
//  String+DateHelper.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation


extension String {
    func parseAsDate() -> Date? {
        return DateHelper.dateParse(str: self)
    }
}
