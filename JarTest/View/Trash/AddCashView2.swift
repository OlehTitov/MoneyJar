//
//  AddCashView2.swift
//  JarTest
//
//  Created by Oleh Titov on 25.06.2022.
//

import SwiftUI
import SwiftUIPager

struct AddCashView2: View {
    @EnvironmentObject private var model: Model
    @Environment(\.presentationMode) var presentationMode // for returning to HomeView
    @StateObject var page: Page = .first() // for SwiftUIPager
    @State private var amount : String = "" // string to display the amount with currency symbols
    @State private var amountAsDouble = 0.0 // amount to store
    @State private var amountForCalculations : Int = 0 // for manipulations in textfield delegate
    @State private var isResponder : Bool = true // for textfield
    @State private var presentAlert : Bool = false // alert when the amount is bigger than 1 billion
    @State private var presentResult : Bool = false
    @State var selectedCurrency = ForeignCurrency.usd
    private var alertText = "Please enter amount less than 1 billion"
    private var descriptionText = "Enter your amount here"
    var body: some View {
        VStack {
            Spacer()
            ForeignCurrencyTextField(text: $amount, isFirstResponder: $isResponder, presentAlert: $presentAlert, amountAsDouble: $amountAsDouble, currency: $selectedCurrency, amount: $amountForCalculations)
                .frame(height: 60)
                .alert(alertText, isPresented: $presentAlert) {
                    Button("OK", role: .cancel, action: {})
                }
                .sheet(isPresented: $presentResult, onDismiss: dismissResults) {
                    AddResultView(mainStack: .constant([]), amount: "20.00 EUR")
                }
            Text(descriptionText)
                .font(.subheadline)
                .foregroundColor(.secondary)
            Spacer()
            Pager(page: page, data: ForeignCurrency.allCases, id: \.self) { item in
                Text(item.rawValue)
                    .font(.title)
                    .bold()
                    .frame(width: 100, height: 40, alignment: .center)
            }
            .onPageChanged({ (newIndex) in
                selectedCurrency = ForeignCurrency.allCases[newIndex] // updating currency property when there is a new index
                self.amount = "" //clear the input textfield - it actually doesn't... needs improvement
            })
            .multiplePagination()
            .interactive(opacity: 0.4)
            .preferredItemSize(CGSize(width: 60, height: 40))
            .itemSpacing(20)
            .interactive(scale: 0.6)
            .itemAspectRatio(0, alignment: .center)
            .frame(height: 50, alignment: .center)
            .padding()
            .onAppear {
                self.page.update(.move(increment: 2))
                selectedCurrency = ForeignCurrency.allCases[page.index]
            }
        }
        .safeAreaInset(edge: .bottom) {
            MainThemeButton(action: addCashToAccount, text: "Add cash")
        }
    }
    func addCashToAccount() {
        self.presentResult = true // shows AddResultView as a sheet
        let finalAsset = Asset.cash(Cash(symbol: selectedCurrency, amount: amountAsDouble, dateAdded: Date.now))
        model.addAsset(asset: finalAsset)
        model.calculateBalance()
        self.amount = "" //clear the input textfield - it actually doesn't... needs improvement
    }
    
    func dismissResults() {
        self.amount = "" //clear the input textfield - it actually doesn't... needs improvement
        self.isResponder = false //resign the textfield as a first responder
        self.presentationMode.wrappedValue.dismiss() // pop to HomeView when user taps Done button on the AddResultView
    }
    
}

struct AddCashView2_Previews: PreviewProvider {
    static var previews: some View {
        AddCashView2()
    }
}
