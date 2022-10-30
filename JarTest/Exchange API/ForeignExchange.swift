//
//  ForeignExchange.swift
//  JarTest
//
//  Created by Oleh Titov on 23.06.2022.
//

import Foundation

// MARK: - ForeignExchange
/*
 Used to handle response from currency exchange API call
 */
struct ForeignExchange: Codable {
    let table: String
    let rates: [String: Double]
    let lastupdate: String
}
