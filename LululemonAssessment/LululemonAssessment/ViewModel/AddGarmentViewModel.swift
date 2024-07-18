//
//  AddGarmentViewModel.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation

class AddGarmentViewModel: ObservableObject {
    let garmentRepositoryManager: GarmentRepository
    @Published var garmentName: String = "" {
        didSet {
            isSaveDisabled = garmentName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        }
    }
    @Published var isSaveDisabled: Bool = true
    @Published var isError: Bool = false
    var errorMessage: String = ""
    
    internal init(garmentRepositoryManager: GarmentRepository) {
        self.garmentRepositoryManager = garmentRepositoryManager
    }
    
    func addGarment(named name: String) {
        do {
            try garmentRepositoryManager.addGarment(named: name.trimmingCharacters(in: .whitespacesAndNewlines))
        } catch let error as PersistenceError {
            self.isError = true
            self.errorMessage = ("Error adding garment: \(error.localizedDescription)")
        } catch {
            // Handle unexpected error
            self.isError = true
            self.errorMessage = ("Unexpected error: \(error.localizedDescription)")
        }
    }
}
