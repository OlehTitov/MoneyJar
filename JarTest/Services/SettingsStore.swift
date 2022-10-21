//
//  SettingsStore.swift
//  JarTest
//
//  Created by Oleh Titov on 10.10.2022.
//

import Foundation
import SwiftUI

class SettingsStore: ObservableObject {
    @Published var soundIsOn: Bool = UserDefaults.standard.bool(forKey: storageKeys.soundIsOn.rawValue) {
            didSet {
                UserDefaults.standard.set(self.soundIsOn, forKey: storageKeys.soundIsOn.rawValue)
            }
        }
    
}
