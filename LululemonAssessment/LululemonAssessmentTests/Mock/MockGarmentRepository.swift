//
//  MockGarmentRepository.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-18.
//

import Foundation
@testable import LululemonAssessment

class MockGarmentRepository: GarmentRepository {
    var mockFetchGarmentsError: Error?
    var mockAddGarmentError: Error?
    
    func addGarment(named name: String) throws {
        if let error = mockAddGarmentError {
            throw error
        }
    }
    
    func fetchGarments(sortedBy sortType: GarmentSortType) throws -> [Garment] {
        if let error = mockFetchGarmentsError {
            throw error
        } else {
            // Return mock data or an empty array for simplicity
            return []
        }
    }
}
