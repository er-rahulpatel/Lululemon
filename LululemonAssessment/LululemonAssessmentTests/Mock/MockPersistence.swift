//
//  MockPersistence.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation
import CoreData
@testable import LululemonAssessment

class MockPersistence: Persistence {
    
    var viewContext: NSManagedObjectContext {
        return managedObjectContext
    }
    
    var mockFetchObjectsResult: [Garment]?
    var mockFetchObjectsError: Error?
    var mockFetchObjectsSortDescriptors: [NSSortDescriptor]?
    
    var mockSaveContextError: Error?
    var hasChangesCalled = false
    var saveContextCalled = false
    
    private var managedObjectContext: NSManagedObjectContext
    
    init(managedObjectContext: NSManagedObjectContext) {
        self.managedObjectContext = managedObjectContext
    }
    
    func fetchObjects<T>(entity: T.Type, predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]?, batchSize: Int, fetchLimit: Int) throws -> [T] where T : NSManagedObject {
        if let error = mockFetchObjectsError {
            throw error
        }
        mockFetchObjectsSortDescriptors = sortDescriptors
        
        let request = NSFetchRequest<T>(entityName: String(describing: entity))
        request.predicate = predicate
        request.sortDescriptors = sortDescriptors
        request.fetchBatchSize = batchSize
        request.fetchLimit = fetchLimit
        
        return try managedObjectContext.fetch(request)
    }
    
    func saveContext() throws {
        hasChangesCalled = true
        saveContextCalled = true
        if let error = mockSaveContextError {
            throw error
        }
        try managedObjectContext.save()
    }
}
