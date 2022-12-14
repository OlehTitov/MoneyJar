//
//  AllAssetsView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.08.2022.
//

import SwiftUI

struct AllAssetsView: View {
    @EnvironmentObject private var model: Model
    @Environment(\.colorScheme) var colorScheme
    var body: some View {
        NavigationStack {
            ZStack {
                Color(UIColor.secondarySystemBackground)
                    .ignoresSafeArea()
                if model.account.assets.isEmpty {
                    EmptyAssetsView()
                } else {
                    List {
                        ForEach(sortAssetsByDate(), id: \.self) { date in
                            Section(header: Text(date.toString(format: .short, showTime: false))) {
                                ForEach(model.account.assets, id: \.self) { asset in
                                    switch asset {
                                    case .cash(let cash):
                                        if cash.dateAdded.onlyDate == date {
                                            TransactionListItem(
                                                image: cash.symbol.rawValue,
                                                name: cash.symbol.longDescription,
                                                assetType: "Currency",
                                                quantity: cash.amount.format(with: cash.symbol),
                                                isCommodity: false
                                            )
                                        }
                                    case .gold(let gold):
                                        if gold.dateAdded.onlyDate == date {
                                            TransactionListItem(
                                                image: "",
                                                name: "Gold \(gold.type)",
                                                assetType: "Commodity",
                                                quantity: "\(gold.weight) \(gold.unit.abbreviate())",
                                                isCommodity: true,
                                                color: .orange
                                            )
                                        }
                                        
                                    case .crypto(let crypto):
                                        if crypto.dateAdded.onlyDate == date {
                                            TransactionListItem(
                                                image: crypto.symbol.rawValue,
                                                name: crypto.symbol.rawValue,
                                                assetType: "Crypto",
                                                quantity: String(crypto.amount),
                                                isCommodity: false
                                            )
                                        }
                                    }
                                }
                            }
                        }
                        .listRowBackground(Color.clear)
                        .listRowSeparator(.hidden)
                        .listRowSeparatorTint(Color.white)
                    }
                    .listStyle(.plain)
                    .scrollContentBackground(.hidden)
                }
            }
            .navigationBarTitle("Transactions")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    func sortAssetsByDate() -> [Date] {
        let assets = model.account.assets
        var dates : [Date] = []
        for asset in assets {
            switch asset {
            case .gold(let gold):
                let date = gold.dateAdded.onlyDate
                if let date = date {
                    dates.append(date)
                }
            case .cash(let cash):
                let date = cash.dateAdded.onlyDate
                if let date = date {
                    dates.append(date)
                }
            case .crypto(let crypto):
                let date = crypto.dateAdded.onlyDate
                if let date = date {
                    dates.append(date)
                }
            }
        }
        let set : Set<Date> = Set(dates)
        let uniqueDates : [Date] = Array(set)
        return uniqueDates
    }
}

struct AllAssetsView_Previews: PreviewProvider {
    static var previews: some View {
        AllAssetsView()
            .environmentObject(Model.dummyData())
            .preferredColorScheme(.dark)
    }
}
