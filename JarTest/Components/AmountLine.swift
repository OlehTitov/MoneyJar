//
//  AmountLine.swift
//  JarTest
//
//  Created by Oleh Titov on 31.07.2022.
//

import SwiftUI

//Used in screens for adding assets
struct AmountLine: View {
    var amount : String
    var showPlaceholder : Bool
    var placeholderText : String
    var font: Font
    var body: some View {
        ZStack {
            Text(amount)
                .font(font)
            if showPlaceholder {
                Text(placeholderText)
                    .font(font)
            } else {
                EmptyView()
            }
        }
        .padding()
    }
}

struct AmountLine_Previews: PreviewProvider {
    static var previews: some View {
        AmountLine(amount: "100", showPlaceholder: false, placeholderText: "0", font: .customLargeTitleFont)
    }
}
