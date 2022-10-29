//
//  AddGoldView2.swift
//  JarTest
//
//  Created by Oleh Titov on 05.07.2022.
//

import SwiftUI

struct AddGoldView2: View {
    @EnvironmentObject private var model: Model
    @StateObject var vm = ViewModel()
    @Binding var mainStack: [NavigationType]
    @State var alertDescription = ""
    @State var selection: Gold.MeasurementUnit = .grams

    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                HStack(spacing: 0) {
                    AmountLine(amount: vm.weight, showPlaceholder: vm.showPlaceholder, placeholderText: "0", font: .customLargeTitleFont)
                    Text(vm.selectedUnit == .grams ? "g" : "oz")
                        
                }
                .font(.customLargeTitleFont)
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
                    NumberPadView(text: $vm.weight, showPlaceholder: $vm.showPlaceholder, amountAsDouble: $vm.amountAsDouble, presentAlert: $vm.presentAlert, alertDescription: $alertDescription, showDecimal: true, currency: .usd, isForCrypto: true)
                        .padding()
                    Button("Add gold") {
                        vm.addGoldToAccount(sc: model)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                    .disabled(vm.weight == "")
                }
                
            }
            .sheet(isPresented: $vm.presentResult, onDismiss: { dismissView() }) {
                AddResultView(mainStack: $mainStack, amount: "\(vm.weight) \(vm.selectedUnit == .grams ? "g" : "oz")")
            }
            .navigationTitle("Add gold")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
    func dismissView() {
        mainStack = []
        model.calculateBalance()
    }
}

struct AddGoldView2_Previews: PreviewProvider {
    static var previews: some View {
        AddGoldView2(mainStack: .constant([]))
            .environmentObject(Model.dummyData())
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
        
        func addGoldToAccount(sc: Model) {
            let gold = Gold(type: selectedType, unit: selectedUnit, weight: Double(weight) ?? 0.0, dateAdded: Date.now)
            let finalAsset = Asset.gold(gold)
            print(finalAsset)
            sc.addAsset(asset: finalAsset)
            self.presentResult = true
        }
    }
}
