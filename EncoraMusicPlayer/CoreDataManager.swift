//
//  CoreDataManager.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 11/04/21.
//

import Foundation
import UIKit
import CoreData

class CoreDataManager {
    
    private init() {}
    
    //Returns the current Persistent Container for CoreData
    class func getContext () -> NSManagedObjectContext {
        return CoreDataManager.persistentContainer.viewContext
    }
    
    
    static var persistentContainer: NSPersistentContainer = {
        //The container that holds both data model entities
        let container = NSPersistentContainer(name: "EncoraMusicPlayer")
        
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                
                //TODO: - Add Error Handling for Core Data
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
            
            
        })
        return container
    }()
    
    // MARK: - Save data into Coredata.
    class func saveContext(complition: (Bool) -> Void) {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
                print("Context - Data Saved")
                complition(true)
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate.
                //You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Insert data in Coredata.
    class func insertDataToCoreData(_ object: [SongModel], complition: ((Bool) -> Void) ) {
        
        defer {
            CoreDataManager.saveContext(complition: { isSucessFull in
                complition(isSucessFull)
            })
        }
        
        for obj in object {
            guard let entity = NSEntityDescription.entity(forEntityName: "Song", in: CoreDataManager
                                                            .getContext())  else { return }
            let storeDic = NSManagedObject(entity: entity, insertInto: CoreDataManager.getContext())
    
            // Set the data to the entity
            storeDic.setValue(obj.title, forKey: "title")
            storeDic.setValue(obj.songInfoURL, forKey: "songInfoURL")
            storeDic.setValue(obj.artist, forKey: "artist")
            storeDic.setValue(obj.imageURL, forKey: "imageURL")
            storeDic.setValue(obj.songURL, forKey: "songURL")
    
        }
    }
    
    // MARK: - Get all data from Coredata.
    class func fetchAllData() -> [Song] {
        print("=========== Retriving songs from DB.=================")
        let all = NSFetchRequest<Song>(entityName: "Song")
        var allData = [Song]()
        
        do {
            let fetched = try CoreDataManager.getContext().fetch(all)
            allData = fetched
        } catch {
            let nserror = error as NSError
            print(nserror.description)
        }
        
        return allData
    }

}
