//
//  KCUIItemsMusicSongItemViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift

class KCUIItunesItemSongViewModel: KCUIItunesAnyItemViewModel {
    
    var artistId: Int?
    var collectionId: Int?
    var trackId: Int?
    var artistName: String?
    var collectionName: String?
    var trackName: String?
    
    var releaseDate: String?
    var artistViewUrl: URL?
    var collectionViewUrl: URL?
    var trackViewUrl: URL?
    var previewUrl: URL?
    var artworkUrl30: URL?
    var artworkUrl60: URL?
    var artworkUrl100: URL?
    
    init(song: KCItunesSong) {
        super.init()
        self.id = song.trackId
        self.artistId = song.artistId
        self.collectionId = song.collectionId
        self.trackId = song.trackId
        self.artistName = song.artistName
        self.collectionName = song.collectionName
        self.trackName = song.trackName
        self.releaseDate = song.releaseDate
        self.artistViewUrl = song.artistViewUrl
        self.collectionViewUrl = song.collectionViewUrl
        self.trackViewUrl = song.trackViewUrl
        self.previewUrl = song.previewUrl
        self.artworkUrl30 = song.artworkUrl30
        self.artworkUrl60 = song.artworkUrl60
        self.artworkUrl100 = song.artworkUrl100
    }
    
    override var title: String {
        return "\(trackName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var desc: String {
        return "\(artistName ?? "")\n\(collectionName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var thumbImageUrl: URL? {
        return artworkUrl100
    }
}
