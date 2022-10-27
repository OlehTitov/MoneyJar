//
//  PrimaryButtonStyle.swift
//  JarTest
//
//  Created by Oleh Titov on 24.08.2022.
//

import SwiftUI

struct MyButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) var isEnabled
    @Environment(\.colorScheme) var colorScheme
    let title: String
    func makeBody(configuration: Self.Configuration) -> some View {
        //MyButtonStyleView(configuration: configuration)
        Text(title)
//            .font(.subheadline.weight(.bold))
            .font(.customButtonTextFont)
            .foregroundColor(isEnabled ? (configuration.isPressed ? .yellow : .white) : .white.opacity(0.8))
            .frame(height: 60)
            .frame(maxWidth: .infinity, alignment: .center)
            .background(isEnabled ? Color.accentColor : Color(UIColor.secondarySystemFill))
//            .background(backgroundColor)
            .cornerRadius(16)
            .opacity(configuration.isPressed ? 0.8 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .padding()
    }
    var backgroundColor: Color {
        colorScheme == .dark ? Color("PurpleNavy") : Color("forestGreen")
    }
}

private extension MyButtonStyle {
  struct MyButtonStyleView: View {
    // tracks if the button is enabled or not
    @Environment(\.isEnabled) var isEnabled
    // tracks the pressed state
    let configuration: MyButtonStyle.Configuration

    var body: some View {
      return configuration.label
        // change the text color based on if it's disabled
            .foregroundColor(isEnabled ? .mirage : .secondary)
        .background(RoundedRectangle(cornerRadius: 12)
          // change the background color based on if it's disabled
            .fill(isEnabled ? Color.turquoiseBlue : Color.turquoiseBlue.opacity(0.5))
            
        )
        // make the button a bit more translucent when pressed
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        // make the button a bit smaller when pressed
        .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
    }
  }
}
