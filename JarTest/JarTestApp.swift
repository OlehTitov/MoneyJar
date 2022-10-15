//
//  JarTestApp.swift
//  JarTest
//
//  Created by Oleh Titov on 18.05.2022.
//

import SwiftUI

@main
struct JarTestApp: App {
    let stateController = StateController(
        storageController: StorageController(),
        exchangeClient: MockExchangeClient(), // change to real client for production
        currencyConverter: CurrencyConverter(),
        awardsManager: AwardsManager()
    )
    
    //This is to check if user has already created the jar
    var jarIsCreated = UserDefaults.standard.bool(forKey: storageKeys.jarIsCreated.rawValue)
    
    var body: some Scene {
        WindowGroup {
            if jarIsCreated {
                TabBarView()
                    .environmentObject(stateController)
            } else {
                WelcomeToJar(viewModel: WelcomeToJarViewModel())
                    .environmentObject(stateController)
            }
        }
    }
}
