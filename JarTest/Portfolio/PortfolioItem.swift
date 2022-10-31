//
//  PortfolioItem.swift
//  JarTest
//
//  Created by Oleh Titov on 31.10.2022.
//

import Foundation
import SwiftUI

struct PortfolioItem: Codable, Hashable, Equatable, Identifiable {
    var assetName: AssetName
    var amountInBaseCurrency: Double
    var id: String { assetName.rawValue }
    enum AssetName: String, Codable {
        case Currency, Gold, Crypto
    }
    
    var color: Color {
        switch assetName {
        case .Currency:
            return Color.red
        case .Gold:
            return Color.yellow
        case .Crypto:
            return Color.orange
        }
    }
}
