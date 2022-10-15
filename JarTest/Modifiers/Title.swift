//
//  Title.swift
//  JarTest
//
//  Created by Oleh Titov on 25.08.2022.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(Font.system(size: 32, weight: .black, design: .default).smallCaps())
//            .font(.largeTitle.bold().smallCaps())
            .multilineTextAlignment(.center)
//            .padding(.vertical, 30)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
}
