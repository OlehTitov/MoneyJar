//
//  JarTestApp.swift
//  JarTest
//
//  Created by Oleh Titov on 18.05.2022.
//

import SwiftUI

@main
struct JarTestApp: App {
    let model = Model(storageController: StorageController(),
                      exchangeClient: MockExchangeClient(), // change to real client for production
                      currencyConverter: CurrencyConverter(),
                      awardsManager: AwardsManager())
    let settingsStore = SettingsStore()
    
    //This is to check if user has already created the jar
    var jarIsCreated = UserDefaults.standard.bool(forKey: StorageKeys.jarIsCreated.rawValue)
    
    var body: some Scene {
        WindowGroup {
            if jarIsCreated {
                TabBarView()
                    .environmentObject(model)
                    .environmentObject(settingsStore)
            } else {
                WelcomeToJar()
                    .environmentObject(model)
                    .environmentObject(settingsStore)
            }
        }
    }
}
