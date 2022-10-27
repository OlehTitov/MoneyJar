//
//  BackgroundView.swift
//  JarTest
//
//  Created by Oleh Titov on 15.10.2022.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Color(UIColor.secondarySystemBackground)
            .ignoresSafeArea()
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
