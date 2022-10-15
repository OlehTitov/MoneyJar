//
//  DuneRoadSunsetGradient.swift
//  JarTest
//
//  Created by Oleh Titov on 30.08.2022.
//

import SwiftUI

struct DuneRoadSunsetGradient: View {
    var body: some View {
        Rectangle()
            .fill(RadialGradient(colors: [Color(hue: 0.14, saturation: 0.03, brightness: 0.98), Color(hue: 0.53, saturation: 0.21, brightness: 0.99)], center: .center, startRadius: 20, endRadius: 650))
            .ignoresSafeArea()
    }
}

struct DuneRoadSunsetGradient_Previews: PreviewProvider {
    static var previews: some View {
        DuneRoadSunsetGradient()
    }
}
