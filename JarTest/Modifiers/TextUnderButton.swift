//
//  TextUnderButton.swift
//  JarTest
//
//  Created by Oleh Titov on 26.08.2022.
//

import SwiftUI

struct TextUnderButton: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.callout)
    }
}

extension View {
    func textUnderButtonStyle() -> some View {
        modifier(TextUnderButton())
    }
}
