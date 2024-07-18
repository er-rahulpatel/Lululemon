//
//  AddGarmentViewModelTests.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-18.
//

import XCTest
@testable import LululemonAssessment

final class AddGarmentViewModelTests: XCTestCase {
    var viewModel: AddGarmentViewModel!
    var mockRepository: MockGarmentRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockRepository = MockGarmentRepository()
        viewModel = AddGarmentViewModel(garmentRepositoryManager: mockRepository)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockRepository = nil
    }
    
    func testInitialValues() {
        // Check initial values
        XCTAssertTrue(viewModel.isSaveDisabled, "Expected isSaveDisabled to be true initially")
        XCTAssertFalse(viewModel.isError, "Expected isError to be false initially")
        XCTAssertEqual(viewModel.errorMessage, "", "Expected errorMessage to be empty initially")
    }
    
    func testGarmentNameValidation() {
        // Given
        viewModel.garmentName = "Sample Garment"
        
        // Then
        XCTAssertFalse(viewModel.isSaveDisabled, "Expected isSaveDisabled to be false after setting a valid garment name")
        
        // Given
        viewModel.garmentName = ""
        
        // Then
        XCTAssertTrue(viewModel.isSaveDisabled, "Expected isSaveDisabled to be true after setting an empty garment name")
    }
    
    func testAddGarmentSuccess() {
        // Given
        mockRepository.mockAddGarmentError = nil
        
        // When
        viewModel.addGarment(named: "New Garment")
        
        // Then
        XCTAssertFalse(viewModel.isError, "Expected isError to be false after successful addition")
        XCTAssertEqual(viewModel.errorMessage, "", "Expected errorMessage to be empty after successful addition")
    }
    
    func testAddGarmentFailurePersistenceError() {
        // Given
        mockRepository.mockAddGarmentError = PersistenceError.saveError("Error")
        
        // When
        viewModel.addGarment(named: "New Garment")
        
        // Then
        XCTAssertTrue(viewModel.isError, "Expected isError to be true after failure")
        XCTAssertNotNil(viewModel.errorMessage, "Expected errorMessage to not be nil after failure")
    }
    
    func testAddGarmentFailureUnexpectedError() {
        // Given
        mockRepository.mockAddGarmentError = NSError(domain: "", code: 404)
        
        // When
        viewModel.addGarment(named: "New Garment")
        
        // Then
        XCTAssertTrue(viewModel.isError, "Expected isError to be true after failure")
        XCTAssertNotNil(viewModel.errorMessage, "Expected errorMessage to not be nil after failure")
    }
}
