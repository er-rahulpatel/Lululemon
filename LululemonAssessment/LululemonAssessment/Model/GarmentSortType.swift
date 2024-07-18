//
//  GarmentSortType.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation

enum GarmentSortType: CaseIterable {
    case name
    case createdAt
    
    var description: String {
        switch self {
        case .name:
            return "Name"
        case .createdAt:
            return "Creation Time"
        }
    }
}
