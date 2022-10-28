//
//  Gold.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

struct Gold : Codable, Hashable, Equatable {
    var type : GoldType
    var unit : MeasurementUnit
    var weight : Double
    var dateAdded : Date
}
