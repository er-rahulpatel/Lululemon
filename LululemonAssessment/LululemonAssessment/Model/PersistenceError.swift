//
//  PersistenceError.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-18.
//

import Foundation

enum PersistenceError: Error, Equatable {
    case fetchError(String)
    case saveError(String)
}
