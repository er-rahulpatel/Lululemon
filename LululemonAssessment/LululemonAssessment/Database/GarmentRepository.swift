//
//  GarmentRepository.swift
//  LululemonAssessment
//
//  Created by Applanding Solutions on 2024-07-17.
//

import Foundation

protocol GarmentRepository {
    func fetchGarments(sortedBy sortType: GarmentSortType) throws -> [Garment]
    func addGarment(named name: String) throws
}


