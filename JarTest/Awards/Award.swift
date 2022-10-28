//
//  Award.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

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
