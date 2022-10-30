//
//  Gold+MeasurementUnit.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

extension Gold {
    enum MeasurementUnit : String, CaseIterable, Codable {
        case grams = "grams"
        case ounces = "ounce"
        
        func abbreviate() -> String {
            switch self {
            case .grams:
                return "g"
            case .ounces:
                return "oz"
            }
        }
    }
}
