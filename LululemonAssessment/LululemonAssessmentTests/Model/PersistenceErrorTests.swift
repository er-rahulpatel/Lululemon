//
//  PersistenceErrorTests.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-18.
//

import XCTest
@testable import LululemonAssessment

final class PersistenceErrorTests: XCTestCase {
    
    // Test case for fetchError
    func testFetchError() {
        let errorDescription = "Failed to fetch data"
        let error = PersistenceError.fetchError(errorDescription)
        
        // Check if the error is of type fetchError
        if case PersistenceError.fetchError(let message) = error {
            XCTAssertEqual(message, errorDescription, "Error message should match")
        } else {
            XCTFail("Expected fetchError, but got \(error)")
        }
    }
    
    // Test case for saveError
    func testSaveError() {
        let errorDescription = "Failed to save data"
        let error = PersistenceError.saveError(errorDescription)
        
        // Check if the error is of type saveError
        if case PersistenceError.saveError(let message) = error {
            XCTAssertEqual(message, errorDescription, "Error message should match")
        } else {
            XCTFail("Expected saveError, but got \(error)")
        }
    }
    
}
