//
//  GoldCoin.swift
//  JarTest
//
//  Created by Oleh Titov on 03.07.2022.
//

import SwiftUI

struct GoldCoin: View {
    var isActive : Bool
    var body: some View {
        VStack(spacing: 4) {
            Text("COIN")
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 5)
            Text("FINE GOLD")
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 5)
            Text("999.9")
                .scaledToFit()
                .minimumScaleFactor(0.5)
                .lineLimit(1)
                .padding(.horizontal, 12)
        }
        .foregroundColor(Color(UIColor.darkGray).opacity(0.6))
        .foregroundStyle(.secondary)
        .frame(width: 130, height: 130)
        .background(LinearGradient(colors: isActive ? [Color(red: 0.99, green: 0.96, blue: 0.73), Color(red: 0.75, green: 0.59, blue: 0.25)] : [Color(UIColor.tertiarySystemBackground), .secondary], startPoint: .topLeading, endPoint: .bottomTrailing))
        .clipShape(Circle())
        
        .overlay {
            Circle()
                .strokeBorder(LinearGradient(colors: isActive ? [Color(red: 0.75, green: 0.59, blue: 0.25).opacity(0.5), Color(red: 0.66, green: 0.47, blue: 0.11).opacity(0.5)] : [Color(UIColor.tertiaryLabel), .secondary], startPoint: .top, endPoint: .bottom), style: .init(lineWidth: 4, lineCap: .round, lineJoin: .round, miterLimit: .infinity))
                .shadow(color: isActive ? Color(red: 0.99, green: 0.96, blue: 0.73) : Color(UIColor.tertiarySystemBackground), radius: 2, x: 0, y: -2)
                //.shadow(color: isActive ? Color(red: 0.75, green: 0.59, blue: 0.25) : Color.secondary, radius: 2, x: 0, y: 2)
        }
        .opacity(isActive ? 1 : 0.2)
    }
}

struct GoldCoin_Previews: PreviewProvider {
    static var previews: some View {
        GoldCoin(isActive: true)
    }
}
