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
                    .frame(width: 120, height: 120)
                    .background(Color.white)
                    .clipShape(Circle())
                Text(settingsTitle)
                Text(newValue)
                    .font(.title)
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: action, label: {})
                    .buttonStyle(MyButtonStyle(title: "Done"))
            }
        }
    }
}

struct SettingsChangeResultView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsChangeResultView(settingsTitle: "Jar renamed", newValue: "For new home", action: {})
    }
}
