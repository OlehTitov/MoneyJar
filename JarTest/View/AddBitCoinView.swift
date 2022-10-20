//
//  AddBitCoinView.swift
//  JarTest
//
//  Created by Oleh Titov on 28.06.2022.
//

import SwiftUI

struct AddBitCoinView: View {
    @EnvironmentObject private var stateController: StateController
    @Binding var mainStack: [NavigationType]
    @State var amountString = ""
    @State var amountAsDouble = 0.0
    @State var showPlaceholder = true
    @State var presentResult = false
    @State var presentAlert = false
    @State var alertText = ""
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                HStack(spacing: 16) {
                    AmountLine(amount: amountString, showPlaceholder: showPlaceholder, placeholderText: "0")
                    Text("BTC")
                        .font(Font.custom("RobotoMono-Medium", size: 46))
                }
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .frame(maxWidth: .infinity, alignment: .center)
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                VStack {
                    NumberPadView(text: $amountString, showPlaceholder: $showPlaceholder, amountAsDouble: $amountAsDouble, presentAlert: $presentAlert, alertDescription: $alertText, showDecimal: true, currency: .usd, isForCrypto: true)
                        .alert(alertText, isPresented: $presentAlert) {
                            Button("OK", role: .cancel, action: {})
                        }
                        .padding()
                    Button(action: addBitCoinToAccount, label: {})
                        .buttonStyle(MyButtonStyle(title: "Add crypto"))
                        .disabled(amountString == "")
                }
            }
            .sheet(isPresented: $presentResult, onDismiss: {dismissView()}) {
                AddResultView(mainStack: $mainStack, amount: "\(amountString) BTC")
        }
        }
    }
    func addBitCoinToAccount() {
        let finalAsset = Asset.crypto(Crypto(symbol: .bitcoin, amount: Double(amountString) ?? 0.0, dateAdded: Date.now))
        print(finalAsset)
        stateController.addAsset(asset: finalAsset)
        self.presentResult = true
    }
    
    func dismissView() {
        mainStack = []
        stateController.calculateBalance()
    }
}

struct AddBitCoinView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            AddBitCoinView(mainStack: .constant([]))
        }
    }
}
