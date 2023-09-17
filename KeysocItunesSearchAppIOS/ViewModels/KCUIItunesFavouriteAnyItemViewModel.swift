//
//  KCUIItunesFavouriteAnyItemViewModel.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import Foundation

/// Favourites view model for iTunes items
class KCUIItunesFavouriteAnyItemViewModel: KCUIItunesAnyItemViewModel {
    
    var _id32: Int32?
    var _title: String?
    var _desc: String?
    var _thumbImageUrl: URL?
    var _itemType: ITunesMusicItemListViewController.ItemType?
    
    init(song: FavouriteSong) {
        super.init()
        self._itemType = .song
        self._id32 = song.id
        self._title = song.title
        self._desc = song.desc
        self._thumbImageUrl = song.thumbImageUrl
    }
    
    init(album: FavouriteAlbum) {
        super.init()
        self._itemType = .album
        self._id32 = album.id
        self._title = album.title
        self._desc = album.desc
        self._thumbImageUrl = album.thumbImageUrl
    }
    
    init(artist: FavouriteArtist) {
        super.init()
        self._itemType = .artist
        self._id32 = artist.id
        self._title = artist.title
        self._desc = artist.desc
        self._thumbImageUrl = artist.thumbImageUrl
    }
    
    override var title: String {
        return "\(_title ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var desc: String {
        return "\(_desc ?? "")".trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    override var thumbImageUrl: URL? {
        return _thumbImageUrl
    }
}
