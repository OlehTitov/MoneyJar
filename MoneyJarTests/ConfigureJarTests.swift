//
//  ConfigureJarTests.swift
//  JarTest
//
//  Created by Oleh Titov on 25.07.2022.
//

import XCTest

class ConfigureJarTests : XCTestCase {
    //sut = System Under Testing
    let sut = ConfigureJarViewModel()
    
    func testkeyboardIsShownImmediatelly() {
        XCTAssertTrue(sut.isFirstResponder)
    }
    
    func testCurrencySelectionTotalIndeces() {
        let actual = sut.currencies.count
        let expected = 3
        XCTAssertEqual(actual, expected)
    }
    
    func testCurrencySelectionByIndex() {
        sut.updateSelectedCurrencyWith(newIndex: 0)
        let actual = sut.selectedCurrency.rawValue
        let expected = "USD"
        XCTAssertEqual(actual, expected)
    }
    
    func testScrollPagerToNextOption() {
        sut.scrollPagerToNextOption()
        let actual = sut.selectedCurrency.rawValue
        let expected = "EUR"
        XCTAssertEqual(actual, expected)
    }
    
    func testNextButtonIsDisabled() {
        sut.name = " "
        XCTAssertTrue(sut.createButtonDisabled)
    }
    
    func testUpdatingSelectedCurrency() {
        sut.updateSelectedCurrencyWith(newIndex: 2)
        let actual = sut.selectedCurrency.rawValue
        let expected = "PLN"
        XCTAssertEqual(actual, expected)
    }
    
    func testNavigationLinkTriggered() {
        sut.nextPressed()
        let actual = sut.selection
        let expected = 1
        XCTAssertEqual(actual, expected)
    }
    
    func testKeyboardIsHiddenWhenNextPressed() {
        sut.nextPressed()
        XCTAssertFalse(sut.isFirstResponder)
    }
}
