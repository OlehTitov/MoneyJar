//
//  SeamlessIconTile.swift
//  JarTest
//
//  Created by Oleh Titov on 26.09.2022.
//

import SwiftUI

struct SeamlessIconTile: View {
    var iconsColor: Color
    var opacity: Double
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: 160, height: 160)
            .overlay {
                ZStack {
                    Image(systemName: "house")
                        .font(.title)
                        .rotationEffect(.degrees(20), anchor: .center)
                        .scaleEffect(1.5)
                    Image(systemName: "giftcard")
                        .font(.largeTitle)
                        .offset(x: 80, y: 80)
                    Image(systemName: "giftcard")
                        .font(.largeTitle)
                        .offset(x: 80, y: -80)
                    
                    Image(systemName: "giftcard")
                        .font(.largeTitle)
                        .offset(x: -80, y: 80)
                    Image(systemName: "giftcard")
                        .font(.largeTitle)
                        .offset(x: -80, y: -80)
                    
                    Image(systemName: "creditcard")
                        .rotationEffect(.degrees(-20), anchor: .center)
                        .font(.largeTitle)
                        .offset(x: -80)
                    Image(systemName: "creditcard")
                        .rotationEffect(.degrees(-20), anchor: .center)
                        .font(.largeTitle)
                        .offset(x: 80)
                    
                    Image(systemName: "cart")
                        .font(.largeTitle)
                        .offset(y: 80)
                    Image(systemName: "cart")
                        .font(.largeTitle)
                        .offset(y: -80)
                }
                .foregroundColor(iconsColor)
                .opacity(opacity)
            }
            .clipped()
            .ignoresSafeArea(.all)
    }
}

struct SeamlessIconTile_Previews: PreviewProvider {
    static var previews: some View {
        SeamlessIconTile(iconsColor: Color.seaGreen, opacity: 0.5)
    }
}
