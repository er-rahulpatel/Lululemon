//
//  GarmentRepositoryManagerTests.swift
//  LululemonAssessmentTests
//
//  Created by Applanding Solutions on 2024-07-17.
//

import XCTest
import CoreData
@testable import LululemonAssessment

final class GarmentRepositoryManagerTests: XCTestCase {
    var mockPersistence: MockPersistence!
    var repositoryManager: GarmentRepositoryManager!
    var managedObjectContext: NSManagedObjectContext!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        
        managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        // Inject mock persistence controller
        mockPersistence = MockPersistence(managedObjectContext: managedObjectContext)
        repositoryManager = GarmentRepositoryManager(persistanceController: mockPersistence)
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        repositoryManager = nil
        mockPersistence = nil
        managedObjectContext = nil
    }
    
    // MARK: - Fetch Garments Tests
    
    func testFetchGarmentsByName() throws {
        // Given
        _ = createGarment(name: "Shirt", createdAt: Date())
        _ = createGarment(name: "Pants", createdAt: Date())
        try managedObjectContext.save()
        
        // When
        let fetchedGarments = try repositoryManager.fetchGarments(sortedBy: .name)
        
        // Then
        XCTAssertEqual(fetchedGarments.count, 2)
        XCTAssertEqual(fetchedGarments.first?.name, "Pants") // Asserting the sorting order
        XCTAssertEqual(fetchedGarments.last?.name, "Shirt")
        
        // Verify that the correct sort descriptor was used
        XCTAssertEqual(mockPersistence.mockFetchObjectsSortDescriptors?.count, 1)
        XCTAssertEqual(mockPersistence.mockFetchObjectsSortDescriptors?.first?.key, "name")
        XCTAssertTrue(mockPersistence.mockFetchObjectsSortDescriptors!.first!.ascending)
    }
    
    func testFetchGarmentsByCreatedAt() throws {
        // Given
        _ = createGarment(name: "Shirt", createdAt: Date())
        _ = createGarment(name: "Pants", createdAt: Date().addingTimeInterval(-3600))
        try managedObjectContext.save()
        
        // When
        let fetchedGarments = try repositoryManager.fetchGarments(sortedBy: .createdAt)
        
        // Then
        XCTAssertEqual(fetchedGarments.count, 2)
        XCTAssertEqual(fetchedGarments.first?.name, "Shirt") // Asserting the sorting order
        XCTAssertEqual(fetchedGarments.last?.name, "Pants")
        
        // Verify that the correct sort descriptor was used
        XCTAssertEqual(mockPersistence.mockFetchObjectsSortDescriptors?.count, 1)
        XCTAssertEqual(mockPersistence.mockFetchObjectsSortDescriptors?.first?.key, "createdAt")
        XCTAssertFalse(mockPersistence.mockFetchObjectsSortDescriptors!.first!.ascending)
    }
    
    func testFetchGarmentsError() throws {
        // Given
        mockPersistence.mockFetchObjectsError = NSError(domain: "Test", code: 123, userInfo: nil)
        
        // When
        XCTAssertThrowsError(try repositoryManager.fetchGarments(sortedBy: .name)) { error in
            // Then
            XCTAssertEqual(error as? PersistenceError, PersistenceError.fetchError("Error fetching garments: \(mockPersistence.mockFetchObjectsError!.localizedDescription)"))
        }
    }
    
    // MARK: - Add Garment Tests
    
    func testAddGarment() throws {
        // Given
        let garmentName = "Dress"
        
        // When
        try repositoryManager.addGarment(named: garmentName)
        try managedObjectContext.save()
        
        // Then
        XCTAssertTrue(mockPersistence.hasChangesCalled)
        XCTAssertTrue(mockPersistence.saveContextCalled)
        
        // Fetch the added garment and assert its properties
        let fetchedGarments = try repositoryManager.fetchGarments(sortedBy: .name)
        XCTAssertEqual(fetchedGarments.count, 1)
        XCTAssertEqual(fetchedGarments.first?.name, garmentName)
    }
    
    func testAddGarmentError() throws {
        // Given
        mockPersistence.mockSaveContextError = NSError(domain: "Test", code: 456, userInfo: nil)
        
        // When
        XCTAssertThrowsError(try repositoryManager.addGarment(named: "Skirt")) { error in
            // Then
            XCTAssertEqual(error as? PersistenceError, PersistenceError.saveError("Error saving garment: \(mockPersistence.mockSaveContextError!.localizedDescription)"))
        }
    }
    
    // Helper method to create a Garment entity
    private func createGarment(name: String, createdAt: Date) -> Garment {
        let garment = Garment(context: mockPersistence.viewContext)
        garment.name = name
        garment.createdAt = createdAt
        return garment
    }
    
}
