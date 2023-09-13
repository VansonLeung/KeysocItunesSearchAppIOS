//
//  KCUIItemsMusicAlbumItemViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation
import KeysocItunesSearchAPIServiceiOS_Swift

class KCUIItunesItemAlbumViewModel: KCUIItunesAnyItemViewModel {
    
    var artistId: Int?
    var collectionId: Int?
    var artistName: String?
    var collectionName: String?
    
    var releaseDate: String?
    var artistViewUrl: URL?
    var collectionViewUrl: URL?
    var previewUrl: URL?
    var artworkUrl30: URL?
    var artworkUrl60: URL?
    var artworkUrl100: URL?
    
    init(album: KCItunesAlbum) {
        super.init()
        self.id = album.collectionId
        self.artistId = album.artistId
        self.collectionId = album.collectionId
        self.artistName = album.artistName
        self.collectionName = album.collectionName
        self.releaseDate = album.releaseDate
        self.artistViewUrl = album.artistViewUrl
        self.collectionViewUrl = album.collectionViewUrl
        self.artworkUrl60 = album.artworkUrl60
        self.artworkUrl100 = album.artworkUrl100
    }
    
    override var title: String {
        return "\(collectionName ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var desc: String {
        return "\(artistName ?? "")\n\(releaseDate?.parseAsDate()?.parseAsStringLocalized() ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var thumbImageUrl: URL? {
        return artworkUrl100
    }
}
