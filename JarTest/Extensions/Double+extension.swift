//
//  Double+extension.swift
//  JarTest
//
//  Created by Oleh Titov on 21.06.2022.
//

import Foundation

extension Double {
    //Converts String to Double and if the number is whole there is no decimals
    func toStringWithDecimalIfNeeded() -> String {
        if floor(self) == self {
            return String(format: "%.0f", self)
        } else {
            return String(format: "%.1f", self)
        }
    }
    
    func toStringWithTwoDecimals() -> String {
        return String(format: "%.2f", self)
    }
    
    //New method to format Doubles into String with currency symbols
    func format(with currency: ForeignCurrency) -> String {
        return currency.format(amount: self)
    }
    
    func currencyFormatter(with locale: String, code: String) -> String {
        let numberFormatter = NumberFormatter()
//        numberFormatter.locale = Locale(identifier: locale)
        numberFormatter.locale = Locale.current
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = code
//        let formattedNumber = numberFormatter.string(from: NSNumber(value: self)) ?? "0"
//        var attributedString = AttributedString(formattedNumber)
//        let container = AttributeContainer()
//        let decimal = container.numberPart(.fraction)
//        let color = container.foregroundColor(.orange)
//        attributedString.replaceAttributes(decimal, with: color)
        
        
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}

extension Double {
    func roundTo(places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension String {
    func getSymbol(forCurrencyCode code: String) -> String? {
       let locale = NSLocale(localeIdentifier: code)
        return locale.displayName(forKey: NSLocale.Key.currencySymbol, value: code)
    }
}

extension Int {
    func currencyFormatter(with locale: String, code: String) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = Locale(identifier: locale)
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = code
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
