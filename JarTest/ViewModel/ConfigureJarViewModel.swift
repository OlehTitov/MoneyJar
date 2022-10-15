//
//  ConfigureJarViewModel.swift
//  JarTest
//
//  Created by Oleh Titov on 25.07.2022.
//

import Foundation
import SwiftUIPager
import UIKit

class ConfigureJarViewModel : ObservableObject {
    @Published var selectedCurrency = ForeignCurrency.eur
    @Published var name = "For "
    @Published var page: Page = .first()
    @Published var isFirstResponder : Bool = true
    @Published var selection: Int? //for Navigation Link
    
    var currencies = [ForeignCurrency.usd, ForeignCurrency.eur, ForeignCurrency.pln]
    var createButtonDisabled : Bool {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty || trimmed == "For" || trimmed == "Fo" || trimmed == "F"
    }
    
    func updateSelectedCurrencyWith(newIndex : Int) {
        selectedCurrency = currencies[newIndex]
    }
    
    func nextPressed() {
        self.selection = 1
        self.isFirstResponder = false
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
    
    func scrollPagerToNextOption() {
        self.page.update(.next)
    }
    
}
