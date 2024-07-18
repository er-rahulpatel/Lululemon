//
//  Persistence.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import CoreData

protocol Persistence {
    var viewContext: NSManagedObjectContext { get }
    
    func fetchObjects<T: NSManagedObject>(
        entity: T.Type,
        predicate: NSPredicate?,
        sortDescriptors: [NSSortDescriptor]?,
        batchSize: Int,
        fetchLimit: Int) throws -> [T]
    
    func saveContext() throws
}

extension Persistence {
    func fetchObjects<T: NSManagedObject>(
        entity: T.Type,
        predicate: NSPredicate? = nil,
        sortDescriptors: [NSSortDescriptor]? = nil,
        batchSize: Int = 0,
        fetchLimit: Int = 0
    ) throws -> [T] {
        return try fetchObjects(
            entity: entity,
            predicate: predicate,
            sortDescriptors: sortDescriptors,
            batchSize: batchSize,
            fetchLimit: fetchLimit
        )
    }
}


