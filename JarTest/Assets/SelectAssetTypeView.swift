//
//  SelectAssetTypeView.swift
//  JarTest
//
//  Created by Oleh Titov on 11.09.2022.
//

import SwiftUI

struct SelectAssetTypeView: View {
    @Binding var mainStack: [NavigationType]
    @Environment(\.colorScheme) var colorScheme
    var screenTitle = "Select asset"
    var body: some View {
        ZStack {
            List {
                ForEach(assetTypes, id: \.self) { asset in
                    switch asset {
                    case .cash(let cash):
                        NavigationLink {
                            AddCashView(
                                mainStack: $mainStack,
                                selectedCurrency: cash.symbol)
                        } label: {
                            TransactionListItem(
                                image: cash.symbol.rawValue,
                                name: cash.symbol.longDescription,
                                assetType: "Currency",
                                quantity: "",
                                isCommodity: false
                            )
                        }
                        .isDetailLink(false)
                    case .gold(_):
                        NavigationLink(destination: AddGoldView2(mainStack: $mainStack)) {
                            TransactionListItem(
                                image: "",
                                name: "Gold",
                                assetType: "Commodity",
                                quantity: "",
                                isCommodity: true,
                                color: .orange
                            )
                        }
                    case .crypto(let crypto):
                        NavigationLink(destination: AddBitCoinView(mainStack: $mainStack)) {
                            TransactionListItem(
                                image: crypto.symbol.rawValue,
                                name: crypto.symbol.rawValue,
                                assetType: "Cryptocurrency",
                                quantity: "",
                                isCommodity: false
                            )
                        }
                    }
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
                .accentColor(.teal)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
        .background(Color(UIColor.secondarySystemBackground))
        .navigationTitle(screenTitle)
        .navigationBarTitleDisplayMode(.large)
    }
        
    var assetTypes : [Asset] {
        var result : [Asset] = []
        //Create and append Gold
        result.append(
            Asset.gold(
                Gold(type: .bar, unit: .grams, weight: 0.0, dateAdded: .now)
            )
        )
        //Create and append Crypto
        result.append(
            Asset.crypto(
                Crypto(symbol: .bitcoin, amount: 0.0, dateAdded: .now)
            )
        )
        //Create and append all currencies
        for currency in ForeignCurrency.allCases {
            let item = Asset.cash(
                Cash(symbol: currency.self, amount: 0.0, dateAdded: .now)
            )
            result.append(item)
        }
        return result
    }
}

struct SelectAssetTypeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SelectAssetTypeView(mainStack: .constant([]))
        }
    }
}
