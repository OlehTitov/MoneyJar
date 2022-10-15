//
//  Coin.swift
//  JarTest
//
//  Created by Oleh Titov on 15.06.2022.
//

import SwiftUI

struct Coin: View {
    var width : Int
    var height : Int
    var goldAsset : Gold
    var body: some View {
        VStack(spacing: 4) {
            Image("mappleLeave")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: getSize(weight: Int(goldAsset.weight)).height - 50, height: getSize(weight: Int(goldAsset.weight)).height - 50, alignment: .center)
                .opacity(0.5)
            Text("\(goldAsset.weight.toStringWithDecimalIfNeeded()) \(goldAsset.unit.abbreviate())")
//            Text("FINE GOLD")
//                .scaledToFit()
//                .minimumScaleFactor(0.5)
//                .lineLimit(1)
//                .padding(.horizontal, 5)
//            Text("999.9")
//                .scaledToFit()
//                .minimumScaleFactor(0.5)
//                .lineLimit(1)
//                .padding(.horizontal, 12)
        }
        .foregroundStyle(.secondary)
        .frame(width: getSize(weight: Int(goldAsset.weight)).height, height: getSize(weight: Int(goldAsset.weight)).height)
        .background(LinearGradient(colors: [Color(red: 0.99, green: 0.96, blue: 0.73), Color(red: 0.75, green: 0.59, blue: 0.25)], startPoint: .topLeading, endPoint: .bottomTrailing))
        
        .clipShape(Circle())
        
        .overlay {
            Circle()
                .stroke(LinearGradient(colors: [Color(red: 0.75, green: 0.59, blue: 0.25).opacity(0.5), Color(red: 0.66, green: 0.47, blue: 0.11).opacity(0.5)], startPoint: .top, endPoint: .bottom), style: .init(lineWidth: 8, lineCap: .round, lineJoin: .round, miterLimit: .infinity))
                //.shadow(color: Color(red: 0.99, green: 0.96, blue: 0.73), radius: 4, x: 0, y: -2)
                //.cornerRadius(8)
                .shadow(color: Color(red: 0.75, green: 0.59, blue: 0.25), radius: 4, x: 0, y: 2)
                //.cornerRadius(CGFloat(radius))
        }
    }
    
    var radius : Int {
        if goldAsset.weight <= 20 {
            return 12
        } else if goldAsset.weight <= 90 {
            return 18
        } else if goldAsset.weight <= 300 {
            return 24
        } else {
            return 12
        }
    }
    
    func getSize(weight: Int) -> (width: CGFloat, height: CGFloat) {
        if weight <= 19 {
            return (width: 60 + CGFloat(weight), height: 100 + CGFloat(weight))
        } else if weight <= 90 {
            return (width: 80 + CGFloat(weight/10), height: 120 + CGFloat(weight/10))
        } else if weight <= 300 {
            return (width: 100 + CGFloat(weight/10), height: 140 + CGFloat(weight/10))
        } else {
            return (width: 60 + CGFloat(weight), height: 100 + CGFloat(weight))
        }
    }
}

struct Coin_Previews: PreviewProvider {
    static var previews: some View {
        Coin(width: 60, height: 100, goldAsset: Gold.init(type: .bar, unit: .grams, weight: 10, dateAdded: Date.now))
    }
}
