//
//  CurrencyConverter.swift
//  JarTest
//
//  Created by Oleh Titov on 26.07.2022.
//

import Foundation

protocol CurrencyConverterProtocol {
    func convertToBaseCurrency(assetValue: Double, usdToAssetRate: Double, usdToBaseCurrencyRate: Double) -> Double
    func convertGoldToBaseCurrency(asset: Gold, usdToGoldRate: Double, usdToBaseCurrencyRate: Double) -> Double
    
}

class CurrencyConverter {
    
    func convertToBaseCurrency(assetValue: Double, usdToAssetRate: Double, usdToBaseCurrencyRate: Double) -> Double {
        let result = assetValue * (usdToBaseCurrencyRate/Double(usdToAssetRate))
        return result
    }
    
    func convertGoldToBaseCurrency(asset: Gold, usdToGoldRate: Double, usdToBaseCurrencyRate: Double) -> Double {
        let baseCurrencyToGoldRate = (usdToGoldRate/usdToBaseCurrencyRate)
        let pricePerTroyOunce = 1/baseCurrencyToGoldRate
        var result : Double = 0.0
        switch asset.unit {
        case .grams :
            let pricePerKilo = pricePerTroyOunce/0.0311034768
            let pricePerGram = pricePerKilo/1000
            result = asset.weight * pricePerGram
        case .ounces:
            result = asset.weight * pricePerTroyOunce
        }
        return result
    }
}
