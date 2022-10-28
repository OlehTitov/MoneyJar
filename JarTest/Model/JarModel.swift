//
//  JarModel.swift
//  JarTest
//
//  Created by Oleh Titov on 27.05.2022.
//

import Foundation
import SwiftUI

struct MasterAccount : Codable {
    var name: String
    var goalAmount: Double
    var baseCurrency: ForeignCurrency
    var rates: [String : Double]
    var lastRatesUpdate : String
    var assets : [Asset] // Container for all assets
    var balance : Double
    var awards: [Award]
    var awardsForPresentation: [Award] {
        let allAwards = awards
        let completedNotPresentedAwards = allAwards.filter { award in
            return award.status == .completed && award.presented == false
        }
        return completedNotPresentedAwards
    }
    var portfolioItems: [PortfolioItem]
    
    var balanceBeforeChange: Double //used for text animation of balance numbers
    var amountAddedOrDeleted: Double {
        balance - balanceBeforeChange
    }
    
    var progress : Double {
        let result = Double(balance/goalAmount)*100
        return result.roundTo(places: 2)
    }
    
//    func balanceWithoutDecimals(localeCode: String) -> String {
//        let formatedBalance = balance.toStringWithTwoDecimals()
//        let locale = NSLocale(localeIdentifier: localeCode)
//        let separator = locale.decimalSeparator
//        let currencyName = locale.currencySymbol
//        let components = formatedBalance.components(separatedBy: separator)
//        return String(components[0])
//    }
    
    mutating func add(_ asset: Asset) {
        assets.append(asset)
    }
    
    mutating func addPortfolioItem(_ item: PortfolioItem) {
        portfolioItems.append(item)
    }
    
    mutating func cleanUpPortfolioItems() {
        portfolioItems.removeAll()
    }
}



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



