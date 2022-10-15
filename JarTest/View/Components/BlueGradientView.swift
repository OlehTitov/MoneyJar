//
//  BlueGradientView.swift
//  JarTest
//
//  Created by Oleh Titov on 04.09.2022.
//

import SwiftUI

struct BlueGradientView: View {
    @Environment(\.colorScheme) var colorScheme
    var darkBlue = [Color("shipCove"), Color("cloudBurst")]
    var spearMint = [Color("mint"), Color("spearMint")]
    var startRadius = 20.0
    var endRadius = 650.0
    
    var body: some View {
        RadialGradient(
            colors: gradientColors,
            center: .top,
            startRadius: startRadius,
            endRadius: endRadius
        )
        .overlay {
            Image("grainBase")
                .opacity(0.1)
        }
        .withSeamlessBackground(with: backgroundPatternColor, opacity: 0.1)
        .ignoresSafeArea()
    }
    
    var gradientColors: [Color] {
        colorScheme == .dark ? darkBlue : spearMint
    }
    
    var backgroundPatternColor: Color {
        colorScheme == .dark ? Color("shipCove") : Color.seaGreen
    }
}

struct BlueGradientView_Previews: PreviewProvider {
    static var previews: some View {
        BlueGradientView()
    }
}
