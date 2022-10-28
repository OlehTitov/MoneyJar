//
//  ForeignCurrency.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

enum ForeignCurrency: String, Codable, CaseIterable {
    case chf = "CHF"
    case usd = "USD"
    case eur = "EUR"
    case pln = "PLN"
    case gbp = "GBP"
    case uah = "UAH"
}
