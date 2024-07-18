//
//  GarmentRepositoryManager.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation

final class GarmentRepositoryManager: GarmentRepository {
    private var persistanceController: Persistence
    
    init(persistanceController: Persistence) {
        self.persistanceController = persistanceController
    }
    
    func fetchGarments(sortedBy sortType: GarmentSortType) throws -> [Garment] {
        let sortDescriptors: [NSSortDescriptor]
        
        switch sortType {
        case .name:
            sortDescriptors = [NSSortDescriptor(keyPath: \Garment.name, ascending: true)]
        case .createdAt:
            sortDescriptors = [NSSortDescriptor(keyPath: \Garment.createdAt, ascending: false)]
        }
        
        do {
            return try persistanceController.fetchObjects(entity: Garment.self, sortDescriptors: sortDescriptors)
        } catch {
            throw PersistenceError.fetchError("Error fetching garments: \(error.localizedDescription)")
        }
    }
    
    func addGarment(named name: String) throws {
        let newGarment = Garment(context: persistanceController.viewContext)
        newGarment.name = name
        newGarment.createdAt = Date()
        
        do {
            try persistanceController.saveContext()
        } catch {
            throw PersistenceError.saveError("Error saving garment: \(error.localizedDescription)")
        }
    }
}
