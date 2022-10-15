//
//  SeamlessBackgroundTest.swift
//  JarTest
//
//  Created by Oleh Titov on 26.09.2022.
//

import SwiftUI

struct SeamlessBackgroundTest: View {
    var body: some View {
        VStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
        }
        
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            renderImage()
                .resizable(resizingMode: .tile)
                
        )
        
        
    }
    
    @MainActor func renderImage() -> Image {
        guard let image = ImageRenderer(content: SeamlessIconTile(iconsColor: Color.seaGreen, opacity: 0.5)).uiImage else { return Image(uiImage: UIImage()) }
        return Image(uiImage: image)
    }
}

struct SeamlessBackgroundTest_Previews: PreviewProvider {
    static var previews: some View {
        SeamlessBackgroundTest()
    }
}
