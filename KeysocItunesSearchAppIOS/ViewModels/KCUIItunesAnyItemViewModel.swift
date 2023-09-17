//
//  SongViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 12/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift


/// Base view model for iTunes items
class KCUIItunesAnyItemViewModel: NSObject {
    var _id: Int?
    
    var itemId: Int? {
        return _id
    }
    
    var title: String {
        return "Itunes item ID: \(_id ?? -1)".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var desc: String {
        return ""
    }
    
    var thumbImageUrl: URL? {
        return nil
    }
}
