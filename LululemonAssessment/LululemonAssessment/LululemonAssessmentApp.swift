//
//  LululemonAssessmentApp.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import SwiftUI

@main
struct LululemonAssessmentApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GarmentsView(garmentListViewModel: GarmentListViewModel(garmentRepositoryManager: GarmentRepositoryManager(persistanceController: PersistenceManager.shared)))
            }
        }
    }
}
