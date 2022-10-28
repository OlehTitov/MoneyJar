//
//  SetAmount.swift
//  JarTest
//
//  Created by Oleh Titov on 19.06.2022.
//

import SwiftUI

struct SetAmount: View {
    @StateObject var viewModel = SetAmountViewModel()
    @State var selectedCurrency : ForeignCurrency
    var jarName : String
    
    var body: some View {
        VStack {
            if viewModel.nextView {
                TabBarView()
            } else {
                Content(
                    viewModel: viewModel,
                    jarName: jarName,
                    selectedCurrency: selectedCurrency
                )
            }
        }
    }
}

struct SetAmount_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SetAmount(selectedCurrency: .usd, jarName: "For home")
                .environmentObject(
                    StateController(
                        storageController: MockStorageController(),
                        exchangeClient: MockExchangeClient(),
                        currencyConverter: CurrencyConverter(), awardsManager: AwardsManager()
                    )
                )
                .preferredColorScheme(.light)
            SetAmount(selectedCurrency: .usd, jarName: "For home")
                .environmentObject(
                    StateController(
                        storageController: MockStorageController(),
                        exchangeClient: MockExchangeClient(),
                        currencyConverter: CurrencyConverter(), awardsManager: AwardsManager()
                    )
                )
                .preferredColorScheme(.dark)
        }
    }
}

extension SetAmount {
    struct Content: View {
        @EnvironmentObject private var stateController: StateController
        @AppStorage(storageKeys.jarIsCreated.rawValue) var jarIsCreated = false
        @StateObject var viewModel : SetAmountViewModel
        var jarName: String
        @State var selectedCurrency: ForeignCurrency
        @State var alertText = ""
        var headline = "What is your goal amount?"
        var buttonText = "Create"
        var jarImage = "Jar-4"
        var jarIcon = "flag.fill"
        var jarHeight = UIScreen.main.bounds.height/5
        
        var body: some View {
            ZStack {
                BackgroundView()
                VStack {
                    Spacer()
                    VStack(spacing: 20) {
                        ZStack {
                            JarShadow(width: 150, height: 20, blurRadius: 12, opacity: 0.5)
                                .offset(y: 94)
                            JarWithFlag(
                                jarImage: jarImage,
                                jarHeight: jarHeight,
                                jarIcon: jarIcon,
                                color: selectedCurrency.color
                            )
                        }
                        Text(headline)
                            .font(.customBodyFont)
                        
                        AmountLine(
                            amount: viewModel.amount,
                            showPlaceholder: viewModel.showPlaceholder,
                            placeholderText: selectedCurrency.placeholder(amount: 0.0), font: .customTitleFont
                        )
                        .minimumScaleFactor(0.5)
                        .frame(height: 100)
                    }
                    Spacer()
                    
                    Button("Start saving") {
                        viewModel.updateAccount(
                            sc: stateController,
                            selectedCurrency: selectedCurrency,
                            jarName: jarName
                        )
                        jarIsCreated = true
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(viewModel.isButtonDisabled)
                    
                    NumberPadView(
                        text: $viewModel.amount,
                        showPlaceholder: $viewModel.showPlaceholder,
                        amountAsDouble: $viewModel.amountAsDouble,
                        presentAlert: $viewModel.presentAlert,
                        alertDescription: $alertText,
                        showDecimal: false,
                        currency: selectedCurrency,
                        isForCrypto: false
                    )
                    .alert(alertText, isPresented: $viewModel.presentAlert) {
                        Button("OK", role: .cancel, action: {})
                    }
                    .padding()
                }
            }
        }
    }
}

//MARK: - SetAmount ViewModel
///This VM is used by 2 views: SetAmount and ChangeAmountView
class SetAmountViewModel : ObservableObject {
    
    @Published var amount : String = ""
    @Published var amountAsDouble = 0.0
    @Published var showPlaceholder = true
    @Published var presentAlert = false
    @Published var nextView = false
    
    //Method is used during Jar creation
    func updateAccount(sc: StateController, selectedCurrency: ForeignCurrency, jarName: String) {
        //update master account
        sc.updateMasterAccount(name: jarName, goalAmount: amountAsDouble, currency: selectedCurrency)
        //Trigger next view
        self.nextView = true
    }
    
    func setExistingAmount() {
        
    }
    
    var isButtonDisabled : Bool {
        return amountAsDouble == 0.0
    }
    
}
