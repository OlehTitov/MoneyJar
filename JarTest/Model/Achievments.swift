//
//  Achievments.swift
//  JarTest
//
//  Created by Oleh Titov on 01.10.2022.
//

import Foundation
import SwiftUI

struct Award: Codable, Hashable, Identifiable {
    var id: Int
    var name: String
    var image: String
    var status: AwardStatus
    var presented: Bool
    var detailedText: String
    
    mutating func wasPresented() {
        self.presented = true
    }
}

enum AwardStatus: String, Codable, Hashable {
    case locked
    case completed
    case unavailable
}
