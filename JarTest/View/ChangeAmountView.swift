//
//  ChangeAmountView.swift
//  JarTest
//
//  Created by Oleh Titov on 20.10.2022.
//

import SwiftUI

struct ChangeAmountView: View {
    @StateObject var viewModel = SetAmountViewModel()
    @Binding var path: NavigationPath
    @EnvironmentObject private var stateController: Model
    @State var alertText = ""
    @State var showResult = false
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                AmountLine(
                    amount: viewModel.amount,
                    showPlaceholder: viewModel.showPlaceholder,
                    placeholderText: stateController.account.baseCurrency.placeholder(amount: stateController.account.goalAmount), font: .customLargeTitleFont
                )
                .minimumScaleFactor(0.5)
                .frame(height: 100)
                .frame(maxWidth: .infinity, alignment: .center)
                .overlay {
                    Text("Just start typing new amount")
                        .font(.customBodyFont)
                        .foregroundColor(.secondary)
                        .offset(y: 80)
                }
                Spacer()
                NumberPadView(
                    text: $viewModel.amount,
                    showPlaceholder: $viewModel.showPlaceholder,
                    amountAsDouble: $viewModel.amountAsDouble,
                    presentAlert: $viewModel.presentAlert,
                    alertDescription: $alertText,
                    showDecimal: false,
                    currency: stateController.account.baseCurrency,
                    isForCrypto: false
                )
                .alert(alertText, isPresented: $viewModel.presentAlert) {
                    Button("OK", role: .cancel, action: {})
                }
                .padding()
            }
            .toolbar {
                Button {
                    stateController.changeGoalAmount(new: viewModel.amountAsDouble)
                    showResult = true
                } label: {
                    Text("Save")
                }
                .disabled(viewModel.amountAsDouble == 0.0)
            }
            .sheet(isPresented: $showResult) {
                SettingsChangeResultView(settingsTitle: "Goal amount changed", newValue: viewModel.amount, action: {doneTapped()})
            }
        }
    }
    
    func doneTapped() {
        path.removeLast()
        showResult = false
    }
}

struct ChangeAmountView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeAmountView(path: .constant(NavigationPath()))
            .environmentObject(Model.dummyData())
    }
}
