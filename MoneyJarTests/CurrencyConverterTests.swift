//
//  CurrencyConverterTests.swift
//  MoneyJarTests
//
//  Created by Oleh Titov on 26.07.2022.
//

import XCTest

class CurrencyConverterTests: XCTestCase {
    
    func testConvertToBaseCurrency1000UahToPln() {
        let sut = CurrencyConverter()
        let actual = sut.convertToBaseCurrency(assetValue: 1000, usdToAssetRate: 29.530445, usdToBaseCurrencyRate: 4.45807)
        let expected = 1000 * (4.45807/29.530445)
        XCTAssertEqual(actual, expected)
    }
    
    func testConvertCryptoToBaseCurrencyUsd() {
        let sut = CurrencyConverter()
        let actual = sut.convertToBaseCurrency(assetValue: 0.5, usdToAssetRate: 4.7416773e-05, usdToBaseCurrencyRate: 1.0)
        let expected = 0.5*(1.0/Double(4.7416773e-05))
        XCTAssertEqual(actual, expected)
    }
    
    func testConvert5GrGoldToBaseCurrencyPLN() {
        let sut = CurrencyConverter()
        let actual = sut.convertGoldToBaseCurrency(asset: Gold(type: .bar, unit: .grams, weight: 5, dateAdded: Date.now), usdToGoldRate: 0.00054739, usdToBaseCurrencyRate: 4.45807)
        let crossRate = 0.00054739/4.45807
        let pricePerTroyOunce = 1/crossRate
        let pricePerKilo = pricePerTroyOunce/0.0311034768
        let pricePerGram = pricePerKilo/1000
        let expected = 5 * pricePerGram
        XCTAssertEqual(actual, expected)
    }
    
}
