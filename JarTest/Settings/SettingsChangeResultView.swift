//
//  SettingsChangeResultView.swift
//  JarTest
//
//  Created by Oleh Titov on 20.10.2022.
//

import SwiftUI

struct SettingsChangeResultView: View {
    var settingsTitle: String
    var newValue: String
    var action: () -> Void
    var body: some View {
        ZStack {
            BackgroundView()
            VStack(spacing: 20) {
                Spacer()
                Image("penguin_waving")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.white)
                    .clipShape(Circle())
                VStack(spacing: 12) {
                    Text(settingsTitle)
                        .font(.customTitleFont)
                    Text(newValue)
                        .font(.customBodyFont)
                }
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                Button("Done") {
                    action()
                }
                .buttonStyle(PrimaryButtonStyle())
            }
        }
    }
}

struct SettingsChangeResultView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsChangeResultView(settingsTitle: "Jar renamed", newValue: "For new home", action: {})
    }
}
