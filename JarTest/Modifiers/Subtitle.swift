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
            .font(Font.custom("RobotoMono-Bold", size: 20).smallCaps())
            .multilineTextAlignment(.center)
    }
}

extension View {
    func subtitleStyle() -> some View {
        modifier(Subtitle())
    }
}
