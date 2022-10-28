//
//  AddCashView3.swift
//  JarTest
//
//  Created by Oleh Titov on 29.06.2022.
//

import SwiftUI
import SwiftUIPager

struct AddCashView3: View {
    @EnvironmentObject private var stateController: StateController
    @StateObject var vm = ViewModel()
    @Binding var mainStack: [NavigationType]
    var selectedCurrency : ForeignCurrency
    @State var alertText = ""
    
    var body: some View {
        ZStack {
            BackgroundView()
                .onAppear {
                    //The beauty of MVVM with SwitfUI...
                    vm.selectedCurrency = selectedCurrency
                }

            VStack {
                Spacer()
                AmountLine(
                    amount: vm.amount,
                    showPlaceholder: vm.showPlaceholder,
                    placeholderText: vm.generatePlaceholder(),
                    font: .customLargeTitleFont
                )
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                Spacer()
            }
            .safeAreaInset(edge: .bottom, content: {
                VStack() {
                    //Numbers pad
                    NumberPadView(
                        text: $vm.amount,
                        showPlaceholder: $vm.showPlaceholder,
                        amountAsDouble: $vm.amountAsDouble,
                        presentAlert: $vm.presentAlert,
                        alertDescription: $alertText,
                        showDecimal: false,
                        currency: vm.selectedCurrency,
                        isForCrypto: false
                    )
                    .alert(alertText, isPresented: $vm.presentAlert) {
                        Button("OK", role: .cancel, action: {})
                    }
                    .padding()
                    
                    //Add button
                    Button("Add currency") {
                        vm.addCashToAccount(sc: stateController)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(vm.amountAsDouble == 0.0)
                }
            })
            
            //Result sheet
            .sheet(isPresented: $vm.presentResult, onDismiss: {dismissView()}) {
                AddResultView(
                    mainStack: $mainStack,
                    amount: "\(vm.amountAsDouble.format(with: selectedCurrency))")
            }
            .navigationTitle("Add currency")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func dismissView() {
        mainStack = []
        stateController.calculateBalance()
    }
}

struct AddCashView3_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AddCashView3(mainStack: .constant([]), selectedCurrency: .usd)
                .environmentObject(StateController.dummyData())
                .preferredColorScheme(.light)
            AddCashView3(mainStack: .constant([]), selectedCurrency: .usd)
                .environmentObject(StateController.dummyData())
                .preferredColorScheme(.dark)
        }
    }
}

extension AddCashView3 {
    class ViewModel : ObservableObject {
        @Published var selectedCurrency : ForeignCurrency = .usd
        @Published var amount : String = "" // string to display the amount with currency symbols
        @Published var amountAsDouble = 0.0 // amount to store
        @Published var amountForCalculations : Int = 0 // for manipulations in textfield delegate
        @Published var presentAlert : Bool = false // alert when the amount is bigger than 1 billion
        @Published var presentResult : Bool = false
        @Published var showPlaceholder = true
        
        func generateCurrencyDescription(sc: StateController) -> String {
            if selectedCurrency == sc.account.baseCurrency {
                return "in my base currency"
            } else {
                return selectedCurrency.longDescription
            }
        }
        
        func generatePlaceholder() -> String {
            let formatter = selectedCurrency.formatter
            let amount = 0
            return formatter.string(from: NSNumber(value: amount))!
        }
        
        func addCashToAccount(sc: StateController) {
            self.presentResult = true // shows AddResultView as a sheet
            let finalAsset = Asset.cash(Cash(symbol: selectedCurrency, amount: amountAsDouble, dateAdded: Date.now))
            sc.addAsset(asset: finalAsset)
        }
    }
}

enum NavigationToResults: String, Hashable {
    case result = "Result"
}
