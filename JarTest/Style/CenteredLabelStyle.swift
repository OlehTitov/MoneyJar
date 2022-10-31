//
//  CenteredLabelStyle.swift
//  JarTest
//
//  Created by Oleh Titov on 31.10.2022.
//

import Foundation
import SwiftUI

struct CenteredLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack(alignment: .center) {
            configuration.icon
            configuration.title
        }
    }
}
