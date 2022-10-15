//
//  MultiProgressView.swift
//  JarTest
//
//  Created by Oleh Titov on 21.08.2022.
//

import SwiftUI

struct MultiProgressView: View {
    @Environment(\.colorScheme) var colorScheme
    var totalAmount: Double
    var items : [PortfolioItem]
    var height: CGFloat
    @State var show = false
    var body: some View {
        GeometryReader { geo in
            VStack {
                ZStack {
                    //Base layer
                    Rectangle()
                        .fill(colorScheme == .dark ? Color("shipCove") : Color("mint"))
                    //Progress items
                    HStack(spacing: 0) {
                        ForEach(items, id: \.self) { item in
                            Rectangle()
                                .fill(item.color)
                                .frame(width: getWidth(item: item, geoProxy: geo), height: height)
                        }
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    //Masking layer
                    HStack {
                        Spacer()
                        Rectangle()
                            .fill(colorScheme == .dark ? Color("shipCove") : Color("mint"))
                            .frame(width: show ? 0 : geo.size.width, alignment: .trailing)
                            .animation(.easeInOut(duration: 2), value: show)
                    }
                }
                .onAppear {
                    if !items.isEmpty {
                        show = true
                    }
                }
                .onDisappear {
                    show = false
                }
                .frame(height: height)
                VStack(spacing: 8) {
                    HStack {
                        Text("0")
                        Spacer()
                        Text("\(Int(goalAmountOrActualAmount))")
                    }
                    .font(.caption)
//                    .foregroundColor(.white.opacity(0.7))
                    HStack(spacing: 12) {
                        ForEach(items) { item in
                            HStack(spacing: 4) {
                                Circle()
                                    .fill(item.color)
                                    .frame(width: 8, height: 8)
                                Text(item.assetName.rawValue)
                                    .font(.caption)
//                                    .foregroundColor(.white.opacity(0.7))
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
    //Find out may be saved amount is bigger than goal
    var actuallySavedAmount: Double {
        var result: Double = 0.0
        for i in items {
            result += i.amountInBaseCurrency
        }
        return result
    }
    
    //Use actual amount if it's bigger than goal
    var goalAmountOrActualAmount: Double {
        if actuallySavedAmount > totalAmount {
            return actuallySavedAmount
        } else {
            return totalAmount
        }
    }
    
    func getWidth(item: PortfolioItem, geoProxy: GeometryProxy) -> CGFloat {
        return geoProxy.size.width * (item.amountInBaseCurrency/goalAmountOrActualAmount)
    }
}

struct MultiProgressView_Previews: PreviewProvider {
    static var previews: some View {
        MultiProgressView(totalAmount: 100_000.00, items: [PortfolioItem(assetName: .Currency, amountInBaseCurrency: 50000.00), PortfolioItem(assetName: .Gold, amountInBaseCurrency: 25000.00)], height: 34)
    }
}
