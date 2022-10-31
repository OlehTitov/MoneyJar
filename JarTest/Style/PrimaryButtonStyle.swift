//
//  PrimaryButtonStyle.swift
//  JarTest
//
//  Created by Oleh Titov on 24.08.2022.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.customButtonTextFont)
            .foregroundColor(isEnabled ? (configuration.isPressed ? .pink.opacity(0.3) : .white) : .white.opacity(0.8))
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(isEnabled ? Color.accentColor : Color(UIColor.secondarySystemFill))
            .cornerRadius(16)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .padding()
    }
}
