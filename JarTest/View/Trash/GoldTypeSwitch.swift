//
//  GoldTypeSwitch.swift
//  JarTest
//
//  Created by Oleh Titov on 03.07.2022.
//

import SwiftUI

struct GoldTypeSwitch: View {
    @Binding var barIsActive : Bool
    @Binding var coinIsActive : Bool
    var body: some View {
        HStack(spacing: 30) {
            GoldBar(isActive: barIsActive)
                .frame(width: 130)
                .onTapGesture {
                    barIsActive.toggle()
                    coinIsActive.toggle()
                }
            Divider()
            GoldCoin(isActive: coinIsActive)
                .onTapGesture {
                    barIsActive.toggle()
                    coinIsActive.toggle()
                }
        }
        .frame(height: 140)
        .padding()
    }
}

struct GoldTypeSwitch_Previews: PreviewProvider {
    static var previews: some View {
        GoldTypeSwitch(barIsActive: .constant(true), coinIsActive: .constant(false))
    }
}
