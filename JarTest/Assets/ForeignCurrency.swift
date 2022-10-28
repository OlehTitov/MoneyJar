//
//  ForeignCurrency.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation
import SwiftUI

enum ForeignCurrency: String, Codable, CaseIterable {
    case chf = "CHF"
    case usd = "USD"
    case eur = "EUR"
    case pln = "PLN"
    case gbp = "GBP"
    case uah = "UAH"
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

