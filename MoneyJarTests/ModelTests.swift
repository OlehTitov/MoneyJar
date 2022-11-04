//
//  ModelTests.swift
//  MoneyJarTests
//
//  Created by Oleh Titov on 01.08.2022.
//

import XCTest
@testable import JarTest

class ModelTests: XCTestCase {
    
    //Create mock dependencies
    let mockStorage = MockStorageController()
    let mockExchange = MockExchangeClient()
    let currencyConverter = CurrencyConverter()
    let awardsManager = AwardsManager()
    
    var model : Model!
    
    override func setUp() {
        model = Model(storageController: mockStorage, exchangeClient: mockExchange, currencyConverter: currencyConverter, awardsManager: awardsManager)
    }
    
    func testStateControllerInitSuccess() {
        // Verify Model init successful
        XCTAssertNotNil(model)
    }
    
    func testUpdateMasterAccount() {
        //Before updating check if name is empty
        XCTAssertTrue(model.account.name == "")
        XCTAssertTrue(model.account.goalAmount == 0)
        XCTAssertTrue(model.account.baseCurrency == .eur)
        
        //Update account
        model.updateMasterAccount(name: "Updated", goalAmount: 100, currency: ForeignCurrency.pln)
        
        //Check new values
        XCTAssertTrue(model.account.name == "Updated")
        XCTAssertTrue(model.account.goalAmount == 100)
        XCTAssertTrue(model.account.baseCurrency == .pln)
    }

    func testAddAsset() {
        //Check if there are no assets yet
        XCTAssertTrue(model.account.assets.isEmpty)
        
        //Create and add asset
        let cash = Cash(symbol: .uah, amount: 1000.00, dateAdded: Date.now)
        let asset = Asset.cash(cash)
        model.addAsset(asset: asset)
        
        //Check if asset is added
        XCTAssertTrue(model.account.assets.count == 1)
    }
    
    func testRatesAreNotEmpty() async {
        //Get currency rates as we need rates to calculate the balance
        await model.getLatestRates(forced: false)
        let asyncWaitDuration = 0.5
          DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
              //Check if there are rates
              XCTAssertTrue(!self.model.account.rates.isEmpty)
          }
    }
    
    func testCalculatebalance() async {
        //Get currency rates as we need rates to calculate the balance
        await model.getLatestRates(forced: true)
        
        //Add some assets
        let cash = Asset.cash(Cash(symbol: .eur, amount: 1000.00, dateAdded: Date.now))
        let cash2 = Asset.cash(Cash(symbol: .eur, amount: 3000.00, dateAdded: Date.now))
        model.account.add(cash)
        model.account.add(cash2)
        
        //Make sure that there are 3 assets in the account
        XCTAssertTrue(model.account.assets.count == 2)
        
        //Expected balance
        let expectedBalance = 4000.00
        
        let asyncWaitDuration = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + asyncWaitDuration) {
            //Calculate balance
            self.model.calculateBalance()
            
            //Check values
            XCTAssertTrue(self.model.account.baseCurrency == .eur)
            XCTAssertEqual(expectedBalance, self.model.account.balance, "Should be equal")
        }
    }

}
