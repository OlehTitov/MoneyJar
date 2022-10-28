//
//  JarModel.swift
//  JarTest
//
//  Created by Oleh Titov on 27.05.2022.
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











enum HomeViewStatus {
    case home
    case listOfTransactions
    case portfolio
}

enum storageKeys: String {
    case greetingSoundPlayed
    case jarIsCreated
    case soundIsOn
    case hapticsIsOn
}



