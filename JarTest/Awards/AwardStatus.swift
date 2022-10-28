//
//  AwardStatus.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

enum AwardStatus: String, Codable, Hashable {
    case locked
    case completed
    case unavailable
}
