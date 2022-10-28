//
//  Gold+GoldType.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

extension Gold {
    enum GoldType : String, CaseIterable , Codable {
        case bar = "bar"
        case coin = "coin"
    }
}
