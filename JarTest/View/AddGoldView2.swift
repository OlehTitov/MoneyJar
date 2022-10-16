//
//  AddGoldView2.swift
//  JarTest
//
//  Created by Oleh Titov on 05.07.2022.
//

import SwiftUI

struct AddGoldView2: View {
    @EnvironmentObject private var stateController: StateController
    @StateObject var vm = ViewModel()
    @Environment(\.dismiss) private var dismiss// for returning to HomeView
    @State var alertDescription = ""
    private var descriptionText = "How much does the gold weights?"
    
    @State var selection: Gold.MeasurementUnit = .grams

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                HStack(spacing: 8) {
                    AmountLine(amount: vm.weight, showPlaceholder: vm.showPlaceholder, placeholderText: "0")
                    Text(vm.selectedUnit == .grams ? "g" : "oz")
                        .font(.system(size: 46, weight: .semibold, design: .default))
                }
                .padding()
                Spacer()
            }
            .safeAreaInset(edge: .top, content: {
                HStack {
                    SegmentedPickerGoldType(selection: $vm.selectedType)
                    Spacer()
                    SegmentedPickerGoldMeasurementUnits(selection: $vm.selectedUnit)
                }
                .padding()
            })
            .safeAreaInset(edge: .bottom) {
                VStack {
                    NumberPadView(text: $vm.weight, showPlaceholder: $vm.showPlaceholder, amountAsDouble: $vm.amountAsDouble, presentAlert: $vm.presentAlert, alertDescription: $alertDescription, showDecimal: true, currency: .constant(.usd), isForCrypto: true)
                        .padding()
                    Button(action: {vm.addGoldToAccount(sc: stateController)}, label: {})
                        .buttonStyle(MyButtonStyle(title: "Add gold"))
                        .disabled(vm.weight == "")
                }
                
            }
            .sheet(isPresented: $vm.presentResult, onDismiss: { dismiss() }) {
                AddResultView(mainStack: .constant([]), amount: "\(vm.weight) \(vm.selectedUnit == .grams ? "g" : "oz")")
            }
            .navigationTitle("Add gold")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct AddGoldView2_Previews: PreviewProvider {
    static var previews: some View {
        AddGoldView2()
            .environmentObject(StateController.dummyData())
    }
}

extension AddGoldView2 {
    class ViewModel : ObservableObject {
        @Published var selectedType = Gold.GoldType.bar
        @Published var selectedUnit = Gold.MeasurementUnit.grams
        @Published var weight : String = "" // weight to display
        @Published var amountAsDouble = 0.0 // weight to store
        @Published var showPlaceholder = true
        @Published var presentResult = false
        @Published var presentAlert = false
        
        func addGoldToAccount(sc: StateController) {
            let gold = Gold(type: selectedType, unit: selectedUnit, weight: Double(weight) ?? 0.0, dateAdded: Date.now)
            let finalAsset = Asset.gold(gold)
            print(finalAsset)
            sc.addAsset(asset: finalAsset)
            self.presentResult = true
        }
        
        func dismissResults(dismiss: DismissAction) {
            dismiss() // pop to HomeView when user taps Done button on the AddResultView
            self.weight = ""
        }
    }
}
