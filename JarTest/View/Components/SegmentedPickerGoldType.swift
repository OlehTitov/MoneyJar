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
            Text("Gold bar")
                .font(.headline)
                .foregroundColor(selection == .bar ? .white : .white.opacity(0.5))
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
            Text("Gold coin")
                .font(.headline)
                .foregroundColor(selection == .coin ? .white : .white.opacity(0.5))
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .onTapGesture {
                    withAnimation {
                        self.selection = .coin
                    }
                }
        }
        .padding(8)
        .background(Color.black.opacity(0.1))
        .clipShape(Capsule())
    }
}

struct SegmentedPickerGoldType_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerGoldType(selection: .constant(.bar))
    }
}
