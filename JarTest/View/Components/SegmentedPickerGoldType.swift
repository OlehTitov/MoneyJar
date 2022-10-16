//
//  SegmentedPickerGoldType.swift
//  JarTest
//
//  Created by Oleh Titov on 08.09.2022.
//

import SwiftUI

struct SegmentedPickerGoldType: View {
    @Binding var selection : Gold.GoldType
    var body: some View {
        HStack {
            Text("Bar")
                .font(.headline)
                .foregroundColor(selection == .bar ? .primary : .secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .onTapGesture {
                    withAnimation {
                        self.selection = .bar
                    }
                }
            Divider()
                .background(Color.white)
                .frame(height: 20)
            Text("Coin")
                .font(.headline)
                .foregroundColor(selection == .coin ? .primary : .secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .onTapGesture {
                    withAnimation {
                        self.selection = .coin
                    }
                }
        }
        .padding(8)
        .padding(.vertical, 8)
        .background(Color.black.opacity(0.1))
        .cornerRadius(8)
    }
}

struct SegmentedPickerGoldType_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerGoldType(selection: .constant(.bar))
    }
}
