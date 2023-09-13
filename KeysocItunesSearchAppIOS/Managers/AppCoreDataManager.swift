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
                let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteSong", into: self.context) as! FavouriteSong
                item.id = Int32(anyItem.id ?? 0)
                item.title = anyItem.title
                item.desc = anyItem.desc

                do {
                    try self.context.save()
                } catch {
                    fatalError("\(error)")
                }
                
            case .album:
                let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteAlbum", into: self.context) as! FavouriteAlbum
                item.id = Int32(anyItem.id ?? 0)
                item.title = anyItem.title
                item.desc = anyItem.desc

                do {
                    try self.context.save()
                } catch {
                    fatalError("\(error)")
                }
                
            case .artist:
                let item = NSEntityDescription.insertNewObject(forEntityName: "FavouriteArtist", into: self.context) as! FavouriteArtist
                item.id = Int32(anyItem.id ?? 0)
                item.title = anyItem.title
                item.desc = anyItem.desc

                do {
                    try self.context.save()
                } catch {
                    fatalError("\(error)")
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
