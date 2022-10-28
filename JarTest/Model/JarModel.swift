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





extension ForeignCurrency {
    func getSymbol(forCurrencyCode code: String) -> String? {
       let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
}

extension ForeignCurrency {
    var formatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
//        numberFormatter.locale = Locale(identifier: self.locale)
        numberFormatter.locale = Locale.current
        numberFormatter.currencyCode = self.rawValue
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    func format(amount: Double) -> String {
        return formatter.string(from: NSNumber(value: amount))!
    }
}

extension ForeignCurrency {
    func placeholder(amount: Double) -> String {
        return formatter.string(from: NSNumber(value: amount))!
    }
}

extension ForeignCurrency {
    var color : Color {
        switch self {
        case .usd:
            return Color(hue: 0.39, saturation: 0.68, brightness: 0.81)
        case .eur:
            return Color(hue: 0.56, saturation: 0.68, brightness: 0.81)
        case .pln:
            return Color(hue: 0.77, saturation: 0.68, brightness: 0.81)
        case .chf:
            return .gray
        case .gbp:
            return .gray
        case .uah:
            return .gray
        }
    }
}

extension ForeignCurrency {
    var locale : String {
        switch self {
        case .chf:
            return "gsw"
        case .usd:
            return "en_US"
        case .eur:
            return "de_DE"
        case .pln:
            return "pl_PL"
        case .gbp:
            return "en_GB"
        case .uah:
            return "uk"
        }
    }
}

extension ForeignCurrency {
    var longDescription : String {
        switch self {
        case .chf:
            return "Swiss Franc"
        case .usd:
            return "US Dollar"
        case .eur:
            return "Euro"
        case .pln:
            return "Polish Złoty"
        case .gbp:
            return "Pound Sterling"
        case .uah:
            return "Ukrainian Hryvnia"
        }
    }
}

struct Crypto : Codable, Hashable, Equatable {
    var symbol : CryptoCurrency
    var amount : Double
    var dateAdded : Date
}

extension Crypto {
    enum CryptoCurrency : String, Codable {
        case bitcoin = "BTC"
        case ethereum = "ETH"
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



