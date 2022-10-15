//
//  PacificHeightsGradient.swift
//  JarTest
//
//  Created by Oleh Titov on 30.08.2022.
//

import SwiftUI

struct PacificHeightsGradient: View {
    var body: some View {
        Rectangle()
            .fill(RadialGradient(colors: [Color(hue: 0.56, saturation: 0.67, brightness: 0.71), Color(hue: 0.60, saturation: 1.00, brightness: 0.18)], center: .center, startRadius: 20, endRadius: 650))
            .ignoresSafeArea()
    }
}

struct PacificHeightsGradient_Previews: PreviewProvider {
    static var previews: some View {
        PacificHeightsGradient()
    }
}
