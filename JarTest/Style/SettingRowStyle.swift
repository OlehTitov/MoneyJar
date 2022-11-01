//
//  SettingRowStyle.swift
//  JarTest
//
//  Created by Oleh Titov on 31.10.2022.
//

import Foundation
import SwiftUI

struct SettingRowStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .frame(height: 48)
            .padding(.horizontal)
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(12)
            .font(.customBodyFont)
    }
}
