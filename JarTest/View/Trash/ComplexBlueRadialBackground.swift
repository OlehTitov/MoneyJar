//
//  ComplexBlueRadialBackground.swift
//  JarTest
//
//  Created by Oleh Titov on 26.07.2022.
//

import Foundation
import SwiftUI

struct ComplexBlueRadialBackground: View {
    var body: some View {
        Color(red: 0.09, green: 0.25, blue: 0.81)
            .overlay {
                RadialGradient(colors: [Color(red: 0.33, green: 0.87, blue: 0.98).opacity(0.8), Color(red: 0.09, green: 0.25, blue: 0.81).opacity(0.4)], center: .center, startRadius: 40, endRadius: 300)
                
            }
    }
}
