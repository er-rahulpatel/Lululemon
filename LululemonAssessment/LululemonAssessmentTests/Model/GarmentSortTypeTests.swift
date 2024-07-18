//
//  GarmentSortTypeTests.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-17.
//

import XCTest
@testable import LululemonAssessment

final class GarmentSortTypeTests: XCTestCase {
    
    // Test case for checking if all enum cases are covered in the description property
    func testDescriptionForAllCases() {
        // Iterate through all cases of GarmentSortType
        for sortType in GarmentSortType.allCases {
            // Get the description
            let description = sortType.description
            
            // Check that the description is not empty
            XCTAssertFalse(description.isEmpty, "Description should not be empty for \(sortType)")
        }
    }
    
    // Test cases for individual enum cases
    func testNameSortDescription() {
        let sortType = GarmentSortType.name
        XCTAssertEqual(sortType.description, "Name", "Description should be 'Name' for name case")
    }
    
    func testCreatedAtSortDescription() {
        let sortType = GarmentSortType.createdAt
        XCTAssertEqual(sortType.description, "Creation Time", "Description should be 'Creation Time' for createdAt case")
    }
    
    func testEnumCount() {
        XCTAssertEqual(GarmentSortType.allCases.count, 2, "Number of enum cases should be 2")
    }
    
}
