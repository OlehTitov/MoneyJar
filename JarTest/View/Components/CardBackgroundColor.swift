//
//  CardBackgroundColor.swift
//  JarTest
//
//  Created by Oleh Titov on 12.09.2022.
//

import SwiftUI

struct CardBackgroundColor: View {
    var body: some View {
        ZStack {
            Color.black
                .opacity(0.1)
            Image("grainBase")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .opacity(0.1)
                .blendMode(.multiply)
        }
    }
}

struct CardBackgroundColor_Previews: PreviewProvider {
    static var previews: some View {
        CardBackgroundColor()
    }
}
