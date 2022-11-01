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
            .padding()
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(16)
            .font(.customBodyFont)
    }
}
