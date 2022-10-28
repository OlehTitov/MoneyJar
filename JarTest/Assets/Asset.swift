//
//  Asset.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

enum Asset : Codable, Hashable, Equatable {
    case gold(Gold)
    case cash(Cash)
    case crypto(Crypto)
}
