//
//  PersistenceManager.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation
import CoreData

struct PersistenceManager: Persistence {
    static let shared = PersistenceManager()
    private let containerName: String = "GarmentStore"
    private let container: NSPersistentContainer
    
    private init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: self.containerName)
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        setupContainer()
    }
    
    init(container: NSPersistentContainer) {
        self.container = container
        setupContainer()
    }
    
    private func setupContainer() {
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace with proper error handling
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
    
    var viewContext: NSManagedObjectContext {
        self.container.viewContext
    }
    
    func fetchObjects<T: NSManagedObject>(
        entity: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        batchSize: Int = 0,
        fetchLimit: Int = 0
    ) throws -> [T] {
        
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = batchSize
        request.fetchLimit = fetchLimit
        
        return try viewContext.fetch(request)
    }
    
    func saveContext() throws {
        guard viewContext.hasChanges else { return }
        try viewContext.save()
    }
}
