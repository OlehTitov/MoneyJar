//
//  StateControllerTests.swift
//  MoneyJarTests
//
//  Created by Oleh Titov on 01.08.2022.
//

import XCTest

class StateControllerTests: XCTestCase {
    
    //Create mock dependencies
    let mockStorage = MockStorageController()
    let mockExchange = MockExchangeClient()
    let currencyConverter = CurrencyConverter()
    
    var stateController : StateController!
    
    override func setUp() {
        stateController = StateController(storageController: mockStorage, exchangeClient: mockExchange, currencyConverter: currencyConverter)
    }
    
    func testStateControllerInitSuccess() {
        // Verify stateController init successful
        XCTAssertNotNil(stateController)
    }
    
    func testUpdateMasterAccount() {
        //Before updating check if name is empty
        XCTAssertTrue(stateController.account.name == "")
        XCTAssertTrue(stateController.account.goalAmount == 0)
        XCTAssertTrue(stateController.account.baseCurrency == .eur)
        
        //Update account
        stateController.updateMasterAccount(name: "Updated", goalAmount: 100, currency: .pln)
        
        //Check new values
        XCTAssertTrue(stateController.account.name == "Updated")
        XCTAssertTrue(stateController.account.goalAmount == 100)
        XCTAssertTrue(stateController.account.baseCurrency == .pln)
    }

    func testAddAsset() {
        //Check if there are no assets yet
        XCTAssertTrue(stateController.account.assets.isEmpty)
        
        //Create and add asset
        let cash = Cash(symbol: .uah, amount: 1000.00, dateAdded: Date.now)
        let asset = Asset.cash(cash)
        stateController.addAsset(asset: asset)
        
        //Check if asset is added
        XCTAssertTrue(stateController.account.assets.count == 1)
    }
    
    func testCalculatebalance() async {
        //Get currency rates as we need rates to calculate the balance
        await stateController.getLatestRates()
        //Check if there are rates
        XCTAssertTrue(!stateController.account.rates.isEmpty)
        
        //Add some assets
        let cash = Asset.cash(Cash(symbol: .eur, amount: 1000.00, dateAdded: Date.now))
        let cash2 = Asset.cash(Cash(symbol: .eur, amount: 3000.00, dateAdded: Date.now))
        stateController.account.add(cash)
        stateController.account.add(cash2)
        
        //Make sure that there are 3 assets in the account
        XCTAssertTrue(stateController.account.assets.count == 2)
        
        //Expected balance
        let expectedBalance = 4000.00
        
        //Calculate balance
        stateController.calculateBalance()
        
        //Check values
        XCTAssertTrue(stateController.account.baseCurrency == .eur)
        XCTAssertEqual(expectedBalance, stateController.account.balance, "Should be equal")
        
    }

}
