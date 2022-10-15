//
//  PrimaryButton.swift
//  JarTest
//
//  Created by Oleh Titov on 21.08.2022.
//

import SwiftUI

struct PrimaryButton: View {
    var action : () -> Void
    var text : String
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color(red: 0.56, green: 0.49, blue: 0.68))
                .frame(width: 280, height: 60, alignment: .center)
                .blur(radius: 40, opaque: false)
            Button(action: action) {
                HStack {
                    Spacer()
                    Text(text)
                        .font(.headline.bold())
                        .foregroundColor(Color(red: 0.08, green: 0.09, blue: 0.17))
                        .padding(6)
                    Spacer()
                }
            }
            .padding()
            .background(Color(red: 0.33, green: 0.85, blue: 1.00))
            .cornerRadius(12)
            .padding()
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            PrimaryButton(action: {}, text: "My button")
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.08, green: 0.09, blue: 0.17))
    }
}
