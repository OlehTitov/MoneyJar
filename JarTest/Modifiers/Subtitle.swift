//
//  Title.swift
//  JarTest
//
//  Created by Oleh Titov on 25.08.2022.
//

import SwiftUI

struct Subtitle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Font.custom("RobotoMono-Medium", size: 18).smallCaps())
            .foregroundColor(.secondary)
            .multilineTextAlignment(.center)
    }
}

extension View {
    func subtitleStyle() -> some View {
        modifier(Subtitle())
    }
}
