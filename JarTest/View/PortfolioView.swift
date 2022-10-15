//
//  PortfolioView.swift
//  JarTest
//
//  Created by Oleh Titov on 06.09.2022.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var stateController: StateController
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                List {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 80)
                        .overlay {
                            MultiProgressView(totalAmount: stateController.account.goalAmount, items: filteredItems, height: 30)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden, edges: .all)
                    ForEach(filteredItems) { item in
                        HStack {
                            Text(item.assetName.rawValue)
                            Spacer()
                            Text(item.amountInBaseCurrency.currencyFormatter(with: locale, code: baseCurrency))
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationTitle("Asset structure")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(colorScheme == .dark ? Color("shipCove") : Color("mint"), for: .navigationBar)
        }
        
    }
    
    var filteredItems : [PortfolioItem] {
        let filtered = stateController.account.portfolioItems.filter { $0.amountInBaseCurrency > 0 }
        let sorted = filtered.sorted {
            $0.amountInBaseCurrency > $1.amountInBaseCurrency
        }
        return sorted
    }
    
    var locale: String {
        stateController.account.baseCurrency.locale
    }
    
    var baseCurrency: String {
        stateController.account.baseCurrency.rawValue
    }
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(StateController.dummyData())
            .preferredColorScheme(.light)
    }
}
