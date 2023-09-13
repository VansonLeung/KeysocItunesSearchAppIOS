//
//  KCUIItunesFavouriteAnyItemViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation

class KCUIItunesFavouriteAnyItemViewModel: KCUIItunesAnyItemViewModel {
    
    var _id: Int32?
    var _title: String?
    var _desc: String?
    var _itemType: ITunesMusicItemListViewController.ItemType?
    
    init(song: FavouriteSong) {
        super.init()
        self._id = song.id
        self._title = song.title
        self._desc = song.desc
        self._itemType = .song
    }
    
    init(album: FavouriteAlbum) {
        super.init()
        self._id = album.id
        self._title = album.title
        self._desc = album.desc
        self._itemType = .album
    }
    
    init(artist: FavouriteArtist) {
        super.init()
        self._id = artist.id
        self._title = artist.title
        self._desc = artist.desc
        self._itemType = .artist
    }
    
    override var title: String {
        return "\(_title ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var desc: String {
        return "\(_desc ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
