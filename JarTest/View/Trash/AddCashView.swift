//
//  AddCashView.swift
//  JarTest
//
//  Created by Oleh Titov on 24.06.2022.
//

import SwiftUI

struct AddCashView: View {
    @EnvironmentObject private var stateController: Model
    @State var amount = "0"
    @State var isFirstResponder = true
    @State var inputCurrency = ForeignCurrency.pln
    var body: some View {
        VStack {
            HStack {
                Spacer()
//                LegacyTextField(text: $amount, isFirstResponder: $isFirstResponder, keyboard: .decimalPad, currency: inputCurrency.rawValue)
//                    .padding()
//                Text(inputCurrency.getSymbol(forCurrencyCode: inputCurrency.rawValue) ?? "")
//                    .font(.system(size: 26).bold())
                Spacer()
            }
            Picker("Select currency", selection: $inputCurrency) {
                ForEach(ForeignCurrency.allCases, id: \.self) { currency in
                    Text(currency.rawValue)
                }
            }
            .pickerStyle(.wheel)
        }
        .safeAreaInset(edge: .bottom) {
            MainThemeButton(action: addCashToAccount, text: "Add cash")
        }
    }
    
    func addCashToAccount() {
        guard let amount = Double(amount) else {
            print("Could not convert amount from string to double")
            return
        }
        let finalAsset = Asset.cash(Cash(symbol: inputCurrency, amount: Double(amount), dateAdded: Date.now))
        stateController.addAsset(asset: finalAsset)
        stateController.calculateBalance()
        print("Added cash to account")
    }
}

struct AddCashView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddCashView()
                .environmentObject(Model.dummyData())
                .navigationTitle("Add some cash")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
