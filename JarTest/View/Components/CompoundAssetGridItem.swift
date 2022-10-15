//
//  CompoundAssetGridItem.swift
//  JarTest
//
//  Created by Oleh Titov on 05.09.2022.
//

import SwiftUI

struct CompoundAssetGridItem: View {
    var assetName: String
    var amount: String
    var color: Color
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(assetName)
                    .font(.body)
                    .foregroundColor(.white.opacity(0.5))
                Circle()
                    .fill(color)
                    .frame(width: 12, height: 12)
            }
            Text(amount.decimalFormat(fontSize: 20, decimalSize: 14))
                .foregroundColor(.white)
        }
        .padding()
        .padding(.vertical, 12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(CardBackgroundColor())
        .cornerRadius(16)
    }
}

struct CompoundAssetGridItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            BlueGradientView()
            HStack {
                CompoundAssetGridItem(assetName: "Gold", amount: "2508.90 €", color: .purple)
                CompoundAssetGridItem(assetName: "Crypto", amount: "4230.45 €", color: .orange)
            }
        }
    }
}
