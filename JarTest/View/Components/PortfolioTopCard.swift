//
//  PortfolioTopCard.swift
//  JarTest
//
//  Created by Oleh Titov on 06.09.2022.
//

import SwiftUI

struct PortfolioTopCard: View {
    var GoalAmountAsDouble: Double
    var totalAmount: String
    var portfolioItems: [PortfolioItem]
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Image(systemName: "briefcase.fill")
                    .font(.title2)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .padding(.bottom, 8)
                Text("Saved amount")
                    .font(.title3)
                    .bold()
                    .foregroundColor(.white.opacity(0.8))
                Text(totalAmount.decimalFormat(fontSize: 56, decimalSize: 32))
                    .foregroundColor(.white)
            }
            
            Rectangle()
                .fill(Color.clear)
                .frame(height: 64)
                .overlay {
                    MultiProgressView(totalAmount: GoalAmountAsDouble, items: portfolioItems, height: 30)
                }
            
        }
        .padding()
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(CardBackgroundColor())
        .cornerRadius(16)
        .padding()
    }
}

struct PortfolioTopCard_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BlueGradientView()
            PortfolioTopCard(GoalAmountAsDouble: 100000.00, totalAmount: "14230.45 €", portfolioItems: [PortfolioItem(assetName: .Currency, amountInBaseCurrency: 50000.00), PortfolioItem(assetName: .Gold, amountInBaseCurrency: 25000.00), PortfolioItem(assetName: .Crypto, amountInBaseCurrency: 10000.00)])
        }
    }
}
