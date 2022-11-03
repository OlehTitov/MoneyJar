//
//  Account.swift
//  JarTest
//
//  Created by Oleh Titov on 28.10.2022.
//

import Foundation

struct Account : Codable {
    var name: String
    var goalAmount: Double
    var baseCurrency: ForeignCurrency
    var rates: [String : Double]
    var lastRatesUpdate : String
    var needToUpdateRates: Bool {
        //Get rates for the first time
        if lastRatesUpdate.isEmpty {
            return true
        }
        //If can not convert string to date
        guard let date = lastRatesUpdate.toDate() else {
            return true
        }
        //If rates are older than one day
        if !Calendar.current.isDateInToday(date) {
            return true
        }
    }
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

