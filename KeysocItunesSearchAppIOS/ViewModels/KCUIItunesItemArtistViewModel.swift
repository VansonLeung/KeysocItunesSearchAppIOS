//
//  KCUIItunesItemArtistViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift

class KCUIItunesItemArtistViewModel: KCUIItunesAnyItemViewModel {
    
    var artistId: Int?
    var artistName: String?
    var artistType: String?

    init(artist: KCItunesArtist) {
        super.init()
        self._id = artist.artistId
        self.artistId = artist.artistId
        self.artistName = artist.artistName
        self.artistType = artist.artistType
    }
    
    override var title: String {
        return "\(artistName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var desc: String {
        return "\(artistType ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
}

