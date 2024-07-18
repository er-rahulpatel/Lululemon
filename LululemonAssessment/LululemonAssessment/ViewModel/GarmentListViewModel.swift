//
//  GarmentListViewModel.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation

class GarmentListViewModel: ObservableObject {
    @Published var garments: [Garment] = []
    let garmentRepositoryManager: GarmentRepository
    @Published var selectedSortType: GarmentSortType = .name {
        didSet {
            sortGarments(by: selectedSortType)
        }
    }
    @Published var refreshList: Bool? = true {
        didSet {
            if refreshList == true {
                fetchGarments(sortedBy: selectedSortType)
                refreshList?.toggle()
            }
        }
    }
    @Published var isError: Bool = false
    var errorMessage: String = ""
    
    internal init(garmentRepositoryManager: GarmentRepository) {
        self.garmentRepositoryManager = garmentRepositoryManager
    }
    /// Fetch garments from database
    func fetchGarments(sortedBy sortType: GarmentSortType) {
        do {
            garments = try garmentRepositoryManager.fetchGarments(sortedBy: sortType)
        } catch let error as PersistenceError {
            self.isError = true
            self.errorMessage = ("Error fetching garments: \(error.localizedDescription)")
        } catch {
            // Handle unexpected error
            self.isError = true
            self.errorMessage = ("Unexpected error: \(error.localizedDescription)")
        }
    }
    
    /// Sort garments
    func sortGarments(by sortType: GarmentSortType) {
        guard !garments.isEmpty else { return }
        switch sortType {
        case .name:
            garments.sort(using: [SortDescriptor(\Garment.name)])
        case .createdAt:
            garments.sort(using: [SortDescriptor(\Garment.createdAt , order: .reverse)])
        }
    }
}
