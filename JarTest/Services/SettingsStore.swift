//
//  SettingsStore.swift
//  JarTest
//
//  Created by Oleh Titov on 10.10.2022.
//

import Foundation
import SwiftUI

class SettingsStore: ObservableObject {
    var jarSettings: [SettingsItem] = [
        SettingsItem(title: "Jar name", icon: "character.cursor.ibeam"),
        SettingsItem(title: "Goal amount", icon: "banknote"),
        SettingsItem(title: "Base currency", icon: "dollarsign")
    ]
    
}
