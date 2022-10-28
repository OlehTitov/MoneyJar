//
//  Crypto.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

struct Crypto : Codable, Hashable, Equatable {
    var symbol : CryptoCurrency
    var amount : Double
    var dateAdded : Date
}
