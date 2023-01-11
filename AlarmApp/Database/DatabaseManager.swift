//
//  DatabaseManager.swift
//  AlarmApp
//
//  Created by Noura Mohammad Althrowi on 17/06/1444 AH.
//

import CoreData

class DatabaseManager {
    static let shared  = DatabaseManager()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "AlarmAppDB")
        container.loadPersistentStores { _, error in
            if let error {
                print(error)
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    func save() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
}
