//
//  SongViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 12/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift

class KCUIItunesAnyItemViewModel: NSObject {
    var id: Int?
    
    var title: String {
        return "Itunes item ID: \(id ?? -1)".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var desc: String {
        return ""
    }
    
    var thumbImageUrl: URL? {
        return nil
    }
}
