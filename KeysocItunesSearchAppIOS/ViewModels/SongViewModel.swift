//
//  SongViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 12/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift

struct SongViewModel: Identifiable {
    let id: Int?
    
    let artistId: Int?
    let collectionId: Int?
    let trackId: Int?
    let artistName: String?
    let collectionName: String?
    let trackName: String?
    
    let releaseDate: String?
    let artistViewUrl: URL?
    let collectionViewUrl: URL?
    let trackViewUrl: URL?
    let previewUrl: URL?
    let artworkUrl30: URL?
    let artworkUrl60: URL?
    let artworkUrl100: URL?

    init(song: KCItunesSong) {
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
    
    var title: String {
        return "\(trackName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var desc: String {
        return "\(artistName ?? "")\n\(collectionName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
