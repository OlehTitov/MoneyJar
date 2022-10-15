//
//  MainThemeButton.swift
//  JarTest
//
//  Created by Oleh Titov on 25.07.2022.
//

import SwiftUI

struct MainThemeButton: View {
    var action : () -> Void
    var text : String
    var body: some View {
        Button(action: action) {
            HStack {
                Spacer()
                Text(text)
                    .font(.headline.bold())
                    .foregroundColor(Color(red: 0.33, green: 0.85, blue: 1.00))
                    .padding(6)
                Spacer()
            }
        }
        .accentColor(Color.black)
        .padding()
        .background(.black.opacity(0.5))
        .cornerRadius(12)
        .padding()
        .padding(.vertical)
    }
}

struct MainThemeButton_Previews: PreviewProvider {
    static var previews: some View {
        MainThemeButton(action: {}, text: "My button")
    }
}
