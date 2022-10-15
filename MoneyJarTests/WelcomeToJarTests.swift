//
//  WelcomeToJarTests.swift
//  MoneyJarTests
//
//  Created by Oleh Titov on 25.07.2022.
//

import XCTest

class WelcomeToJarTests : XCTestCase {
    func testCreateButtonPressed() {
        //sut = System Under Testing
        let sut = WelcomeToJarViewModel()
        sut.createPressed()
        XCTAssertTrue(sut.isCreateJarPressed)
    }
}
