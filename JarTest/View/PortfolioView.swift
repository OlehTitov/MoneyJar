//
//  PortfolioView.swift
//  JarTest
//
//  Created by Oleh Titov on 06.09.2022.
//

import SwiftUI

struct PortfolioView: View {
    @EnvironmentObject private var stateController: StateController
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    Rectangle()
                        .fill(Color.clear)
                        .frame(height: 120)
                        .overlay {
                            MultiProgressView(totalAmount: stateController.account.goalAmount, items: filteredItems, height: 30)
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden, edges: .all)
                    ForEach(filteredItems) { item in
                        HStack {
                            Text(item.assetName.rawValue)
                                .bold()
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
            .background(Color(UIColor.secondarySystemBackground))
            .navigationTitle("Asset structure")
            .navigationBarTitleDisplayMode(.large)
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
        Group {
            PortfolioView()
                .environmentObject(StateController.dummyData())
                .preferredColorScheme(.light)
            PortfolioView()
                .environmentObject(StateController.dummyData())
                .preferredColorScheme(.dark)
        }
    }
}
