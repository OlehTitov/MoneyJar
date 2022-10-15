//
//  AnimatableNumberModifier.swift
//  JarTest
//
//  Created by Oleh Titov on 16.08.2022.
//

import Foundation
import SwiftUI

//Solution by: https://stefanblos.com/posts/animating-number-changes/

struct AnimatableNumberModifier: AnimatableModifier {
    var numberString: String
    
    var animatableData: String {
        get { numberString }
        set { numberString = newValue }
    }
    
    func body(content: Content) -> some View {
        content
            .overlay(
                Text(numberString)
                    .font(Font.system(size: 46, weight: .bold, design: .monospaced))
            )
    }
}

extension View {
    func animatingOverlay(for number: String) -> some View {
        modifier(AnimatableNumberModifier(numberString: number))
    }
}
