//
//  JumboMonospacedAmount.swift
//  JarTest
//
//  Created by Oleh Titov on 26.08.2022.
//

import SwiftUI

struct JumboMonospacedAmount: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 46, weight: .regular, design: .monospaced))
            .foregroundColor(Color.white)
    }
}

extension View {
    func jumboMonospacedAmountStyle() -> some View {
        modifier(JumboMonospacedAmount())
    }
}
