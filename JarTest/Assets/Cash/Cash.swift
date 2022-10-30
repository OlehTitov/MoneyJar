//
//  Cash.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

struct Cash: Codable, Hashable, Equatable {
    var symbol: ForeignCurrency
    var amount: Double
    var dateAdded: Date
}
