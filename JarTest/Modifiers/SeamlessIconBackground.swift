//
//  SeamlessIconBackground.swift
//  JarTest
//
//  Created by Oleh Titov on 26.09.2022.
//

import Foundation
import SwiftUI

struct SeamlessIconBackground: ViewModifier {
    var iconColor: Color
    var opacity: Double

    func body(content: Content) -> some View {
        ZStack(alignment: .bottomTrailing) {
            content
                .overlay{
                    renderImage()
                        .resizable(resizingMode: .tile)
                }
        }
    }
    
    @MainActor func renderImage() -> Image {
        guard let image = ImageRenderer(content: IconsLineWidthTest(iconsColor: iconColor, opacity: opacity)).uiImage else { return Image(uiImage: UIImage()) }
        return Image(uiImage: image)
    }
}

extension View {
    func withSeamlessBackground(with iconColor: Color, opacity: Double) -> some View {
        modifier(SeamlessIconBackground(iconColor: iconColor, opacity: opacity))
    }
}
