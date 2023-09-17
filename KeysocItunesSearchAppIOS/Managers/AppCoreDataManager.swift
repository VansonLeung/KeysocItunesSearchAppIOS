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
    

    /// Add any item to FavouritesXXX
    ///
    /// - Parameters:
    ///   - anyItem: `KCUIItunesAnyItemViewModel`
    ///   - itemType: `ITunesMusicItemListViewController.ItemType`
    func itunesAnyItem_addToFavourites(
        anyItem: KCUIItunesAnyItemViewModel?,
        itemType: ITunesMusicItemListViewController.ItemType
    ) {
        if let anyItem = anyItem {
            switch itemType {
            case .song:
                do {
                    let newId = Int32(anyItem.itemId ?? 0)
                    let request = NSFetchRequest<FavouriteSong>(entityName: "FavouriteSong")
                    request.predicate = NSPredicate(format: "id = %d", newId)

                    var isUnique = true
                    
                    let results = try self.context.fetch(request)
                    for item in results {
                        self.context.delete(item)
                        isUnique = false
                    }
                        
                    let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteSong", into: self.context) as! FavouriteSong
                    item.created_at = Date()
                    item.id = Int32(anyItem.itemId ?? 0)
                    item.title = anyItem.title
                    item.desc = anyItem.desc
                    item.thumbImageUrl = anyItem.thumbImageUrl

                    try self.context.save()

                    if isUnique {
                        RootViewController.current?.showToast(message: "favourite_item_added".i18n())
                    } else {
                        RootViewController.current?.showToast(message: "favourite_item_already_added".i18n())
                    }
                } catch {
//                    fatalError("\(error)")
                    RootViewController.current?.showToast(message: error.localizedDescription)
                }
                
                
            case .album:
                do {
                    let newId = Int32(anyItem.itemId ?? 0)
                    let request = NSFetchRequest<FavouriteAlbum>(entityName: "FavouriteAlbum")
                    request.predicate = NSPredicate(format: "id = %d", newId)

                    var isUnique = true
                    
                    let results = try self.context.fetch(request)
                    for item in results {
                        self.context.delete(item)
                        isUnique = false
                    }
                        
                    let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteAlbum", into: self.context) as! FavouriteAlbum
                    item.created_at = Date()
                    item.id = Int32(anyItem.itemId ?? 0)
                    item.title = anyItem.title
                    item.desc = anyItem.desc
                    item.thumbImageUrl = anyItem.thumbImageUrl

                    try self.context.save()
                    
                    if isUnique {
                        RootViewController.current?.showToast(message: "favourite_item_added".i18n())
                    } else {
                        RootViewController.current?.showToast(message: "favourite_item_already_added".i18n())
                    }
                } catch {
//                    fatalError("\(error)")
                    RootViewController.current?.showToast(message: error.localizedDescription)
                }
                
                
            case .artist:
                do {
                    let newId = Int32(anyItem.itemId ?? 0)
                    let request = NSFetchRequest<FavouriteArtist>(entityName: "FavouriteArtist")
                    request.predicate = NSPredicate(format: "id = %d", newId)

                    var isUnique = true
                    
                    let results = try self.context.fetch(request)
                    for item in results {
                        self.context.delete(item)
                        isUnique = false
                    }
                        
                    let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteArtist", into: self.context) as! FavouriteArtist
                    item.created_at = Date()
                    item.id = Int32(anyItem.itemId ?? 0)
                    item.title = anyItem.title
                    item.desc = anyItem.desc
                    item.thumbImageUrl = anyItem.thumbImageUrl

                    try self.context.save()
                    
                    if isUnique {
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
    
    
    /// Delete any item from FavouritesXXX
    ///
    /// - Parameters:
    ///   - id: `id` of the entity item
    ///   - itemType: `ITunesMusicItemListViewController.ItemType`
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

    
    /// Select list of FavouritesXXX
    ///
    /// - Parameters:
    ///   - entityType: `FavouriteSong`, `FavouriteAlbum`, or `FavouriteArtist`
    ///
    /// - Returns: List of items of `entityType`
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

    
    
    /// Select list of FavouritesXXX by `id`
    ///
    /// - Parameters:
    ///   - id: `id` of entity items
    ///   - entityType: `FavouriteSong`, `FavouriteAlbum`, or `FavouriteArtist`
    ///
    /// - Returns: List of items of `entityType`
    func itunesAnyItem_selectFavoritesById<T: NSManagedObject>(
        id: Int,
        entityType: T.Type
    ) -> [T] {
        var array: [T] = []
        let request = NSFetchRequest<T>(entityName: T.entity().name ?? "")
        request.predicate = NSPredicate(format: "id = %d", id)
        do {
            let results = try self.context.fetch(request)
            array.append(contentsOf: results.reversed())
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        return array

    }
    
    
    /// Insert or delete any iTunes search history
    ///
    /// - Parameters:
    ///   - text: search text
    func historyItunesSearch_upsert(
        text: String?
    ) {
        if let text = text?.trimmingCharacters(in: .whitespacesAndNewlines),
           text != "" {
            do {
                let request = NSFetchRequest<HistoryItunesSearch>(entityName: HistoryItunesSearch.entity().name ?? "")
                request.predicate = NSPredicate(format: "text = %@", text)
                do {
                    let results = try self.context.fetch(request)
                    for r in results {
                        self.context.delete(r)
                    }
                    try self.context.save()
                }catch{
                    fatalError("Failed to fetch data: \(error)")
                }
                
                
                let item = NSEntityDescription.insertNewObject(forEntityName: "HistoryItunesSearch", into: self.context) as! HistoryItunesSearch
                item.created_at = Date()
                item.text = text

                try self.context.save()
            } catch {
//                RootViewController.current?.showToast(message: error.localizedDescription)
            }
        }
    }
    
    
    /// Select list of iTunes search history
    ///
    /// - Parameters:
    ///   - entityType: `HistoryItunesSearch`
    ///
    /// - Returns: List of items of `entityType`
    func historyItunesSearch_select<T: NSManagedObject>(
        entityType: T.Type
    ) -> [T] {
        let MAX_COUNT = 5
        
        var array: [T] = []
        let request = NSFetchRequest<T>(entityName: T.entity().name ?? "")
        do {
            let results = try self.context.fetch(request)
            
            if results.count > MAX_COUNT {
                for k in 0 ..< results.count - MAX_COUNT {
                    self.context.delete(results[k])
                }
                
                try self.context.save()
            }
            
            array.append(contentsOf: results.reversed())
        }catch{
            fatalError("Failed to fetch data: \(error)")
        }
        return array

    }

    
    
}
