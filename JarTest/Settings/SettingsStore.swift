//
//  SettingsStore.swift
//  JarTest
//
//  Created by Oleh Titov on 10.10.2022.
//

import Foundation
import SwiftUI

class SettingsStore: ObservableObject {
    @Published var soundIsOn: Bool = UserDefaults.standard.bool(forKey: StorageKeys.soundIsOn.rawValue) {
            didSet {
                UserDefaults.standard.set(self.soundIsOn, forKey: StorageKeys.soundIsOn.rawValue)
            }
        }
    
    @Published var hapticsIsOn: Bool = UserDefaults.standard.bool(forKey: StorageKeys.hapticsIsOn.rawValue) {
            didSet {
                UserDefaults.standard.set(self.hapticsIsOn, forKey: StorageKeys.hapticsIsOn.rawValue)
            }
        }
    
    func initialSetup() {
        soundIsOn = true
        hapticsIsOn = true
    }
    
}
