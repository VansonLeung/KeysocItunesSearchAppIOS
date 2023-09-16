//
//  AppCoreDataManager.swift
//  KeysocItunesSearchAppIOS
//
//  Created by Vanson Leung on 13/9/2023.
//

import CoreData
import UIKit

class AppCoreDataManager {
    static let shared = AppCoreDataManager()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func itunesAnyItem_addToFavourites(
        anyItem: KCUIItunesAnyItemViewModel?,
        itemType: ITunesMusicItemListViewController.ItemType
    ) {
        if let anyItem = anyItem {
            switch itemType {
            case .song:
                let newId = Int32(anyItem.itemId ?? 0)
                let request = NSFetchRequest<FavouriteSong>(entityName: "FavouriteSong")
                request.predicate = NSPredicate(format: "id = %d", newId)
                do {
                    var isUnique = true
                    
                    let results = try self.context.fetch(request)
                    if results.contains(where: { it in
                        return it.id == newId
                    }) {
                        isUnique = false
                    }
                        
                    if isUnique {
                        let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteSong", into: self.context) as! FavouriteSong
                        item.id = Int32(anyItem.itemId ?? 0)
                        item.title = anyItem.title
                        item.desc = anyItem.desc
                        item.thumbImageUrl = anyItem.thumbImageUrl

                        try self.context.save()
                        RootViewController.current?.showToast(message: "favourite_item_added".i18n())
                    } else {
                        RootViewController.current?.showToast(message: "favourite_item_already_added".i18n())
                    }
                } catch {
//                    fatalError("\(error)")
                    RootViewController.current?.showToast(message: error.localizedDescription)
                }
                
                
            case .album:
                let newId = Int32(anyItem.itemId ?? 0)
                let request = NSFetchRequest<FavouriteAlbum>(entityName: "FavouriteAlbum")
                request.predicate = NSPredicate(format: "id = %d", newId)
                do {
                    var isUnique = true
                    
                    let results = try self.context.fetch(request)
                    if results.contains(where: { it in
                        return it.id == newId
                    }) {
                        isUnique = false
                    }
                        
                    if isUnique {
                        let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteAlbum", into: self.context) as! FavouriteAlbum
                        item.id = Int32(anyItem.itemId ?? 0)
                        item.title = anyItem.title
                        item.desc = anyItem.desc
                        item.thumbImageUrl = anyItem.thumbImageUrl

                        try self.context.save()
                        RootViewController.current?.showToast(message: "favourite_item_added".i18n())
                    } else {
                        RootViewController.current?.showToast(message: "favourite_item_already_added".i18n())
                    }
                } catch {
//                    fatalError("\(error)")
                    RootViewController.current?.showToast(message: error.localizedDescription)
                }
                
                
            case .artist:
                let newId = Int32(anyItem.itemId ?? 0)
                let request = NSFetchRequest<FavouriteArtist>(entityName: "FavouriteArtist")
                request.predicate = NSPredicate(format: "id = %d", newId)
                do {
                    var isUnique = true
                    
                    let results = try self.context.fetch(request)
                    if results.contains(where: { it in
                        return it.id == newId
                    }) {
                        isUnique = false
                    }
                        
                    if isUnique {
                        let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteArtist", into: self.context) as! FavouriteArtist
                        item.id = Int32(anyItem.itemId ?? 0)
                        item.title = anyItem.title
                        item.desc = anyItem.desc
                        item.thumbImageUrl = anyItem.thumbImageUrl

                        try self.context.save()
                        RootViewController.current?.showToast(message: "favourite_item_added".i18n())
                    } else {
                        RootViewController.current?.showToast(message: "favourite_item_already_added".i18n())
                    }
                } catch {
//                    fatalError("\(error)")
                    RootViewController.current?.showToast(message: error.localizedDescription)
                }
                
            }
        }
    }
    
    
    func itunesAnyItem_deleteFromFavourites(
        id: Int,
        itemType: ITunesMusicItemListViewController.ItemType
    ) {
        switch itemType {
        case .song:
            
            let request = NSFetchRequest<FavouriteSong>(entityName: "FavouriteSong")
            request.predicate = NSPredicate(format: "id = %d", id)
            do {
                let results = try self.context.fetch(request)
                for item in results {
                    context.delete(item)
                }
                try self.context.save()
                RootViewController.current?.showToast(message: "favourite_item_removed".i18n())
            } catch {
                fatalError("Failed to fetch data: \(error)")
            }
            
            
        case .album:
            
            let request = NSFetchRequest<FavouriteAlbum>(entityName: "FavouriteAlbum")
            request.predicate = NSPredicate(format: "id = %d", id)
            do {
                let results = try self.context.fetch(request)
                for item in results {
                    context.delete(item)
                }
                try self.context.save()
                RootViewController.current?.showToast(message: "favourite_item_removed".i18n())
            } catch {
                fatalError("Failed to fetch data: \(error)")
            }
            
            
        case .artist:
            
            let request = NSFetchRequest<FavouriteArtist>(entityName: "FavouriteArtist")
            request.predicate = NSPredicate(format: "id = %d", id)
            do {
                let results = try self.context.fetch(request)
                for item in results {
                    context.delete(item)
                }
                try self.context.save()
                RootViewController.current?.showToast(message: "favourite_item_removed".i18n())
            } catch {
                fatalError("Failed to fetch data: \(error)")
            }
            
            
        }
        
        
    }

    
    func itunesAnyItem_selectFavorites<T: NSManagedObject>(
        entityType: T.Type
    ) -> [T] {
        var array: [T] = []
        let request = NSFetchRequest<T>(entityName: T.entity().name ?? "")
        do {
            let results = try self.context.fetch(request)
            for result in results {
                array.append(result)
            }
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        return array

    }

    
    
    func itunesAnyItem_selectFavoritesById<T: NSManagedObject>(
        id: Int,
        entityType: T.Type
    ) -> [T] {
        var array: [T] = []
        let request = NSFetchRequest<T>(entityName: T.entity().name ?? "")
        request.predicate = NSPredicate(format: "id = %d", id)
        do {
            let results = try self.context.fetch(request)
            for result in results {
                array.append(result)
            }
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        return array

    }
    
    
}
