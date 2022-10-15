//
//  ExchangeClientProtocol.swift
//  JarTest
//
//  Created by Oleh Titov on 01.08.2022.
//

import Foundation

protocol ExchangeClientProtocol {
    func getLatestRates() async -> ForeignExchange?
}
