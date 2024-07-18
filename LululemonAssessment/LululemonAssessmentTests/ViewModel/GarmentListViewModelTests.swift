//
//  GarmentListViewModelTests.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-18.
//

import XCTest
@testable import LululemonAssessment

final class GarmentListViewModelTests: XCTestCase {
    
    var viewModel: GarmentListViewModel!
    var mockRepository: MockGarmentRepository!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockRepository = MockGarmentRepository()
        viewModel = GarmentListViewModel(garmentRepositoryManager: mockRepository)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        mockRepository = nil
    }
    
    func testFetchGarmentsSuccess() {
        // Given
        mockRepository.mockFetchGarmentsError = nil
        
        // When
        viewModel.fetchGarments(sortedBy: .name)
        
        // Then
        XCTAssertEqual(viewModel.garments.count, 0, "Expected garments array to be empty")
        XCTAssertFalse(viewModel.isError, "Expected isError to be false")
        XCTAssertEqual(viewModel.errorMessage, "", "Expected errorMessage to be empty")
    }
    
    func testFetchGarmentsFailurePersistenceError() {
        // Given
        mockRepository.mockFetchGarmentsError = PersistenceError.fetchError("Error")
        
        // When
        viewModel.fetchGarments(sortedBy: .name)
        
        // Then
        XCTAssertEqual(viewModel.garments.count, 0, "Expected garments array to be empty")
        XCTAssertTrue(viewModel.isError, "Expected isError to be true")
        XCTAssertNotNil(viewModel.errorMessage, "Expected errorMessage to not be nil")
    }
    
    func testFetchGarmentsFailureUnexpectedError() {
        // Given
        mockRepository.mockFetchGarmentsError = NSError(domain: "", code: 404)
        
        // When
        viewModel.fetchGarments(sortedBy: .name)
        
        // Then
        XCTAssertEqual(viewModel.garments.count, 0, "Expected garments array to be empty")
        XCTAssertTrue(viewModel.isError, "Expected isError to be true")
        XCTAssertNotNil(viewModel.errorMessage, "Expected errorMessage to not be nil")
    }
    
    func testSelectedSortTypeChange() {
        // When
        viewModel.selectedSortType = .createdAt
        
        // Then
        XCTAssertEqual(viewModel.selectedSortType, .createdAt, "Expected selectedSortType to be .createAt")
        // Additional assertions based on the expected behavior after sort type change
    }
    
    func testRefreshListTrue() {
        // When
        viewModel.refreshList = true
        
        // Then
        XCTAssertEqual(viewModel.refreshList, false, "Expected refreshList to be false after toggling")
        // Additional assertions based on the expected behavior after refreshing the list
    }
    
    func testRefreshListFalse() {
        // When
        viewModel.refreshList = false
        
        // Then
        XCTAssertEqual(viewModel.refreshList, false, "Expected refreshList to be false as it is toggling only when true")
    }
}
