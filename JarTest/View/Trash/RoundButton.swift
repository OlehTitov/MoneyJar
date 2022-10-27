//
//  RoundButton.swift
//  JarTest
//
//  Created by Oleh Titov on 21.08.2022.
//

import SwiftUI

struct RoundButton: View {
    var action : () -> Void
    var text : String
    var color1: Color
    var color2: Color
    var body: some View {
        ZStack {
//            Circle()
//                .fill(Color.turquoiseBlue)
//                .frame(width: 50, height: 50, alignment: .center)
//                .blur(radius: 10, opaque: false)
            Button(action: action) {
                HStack {
                    Circle()
                        .fill(
                            LinearGradient(
                                colors: [color1, color2],
                                startPoint: .top,
                                endPoint: .bottom)
                        )
                        .frame(width: 60, height: 60, alignment: .center)
                        .overlay {
                            Image(text)
                                .resizable()
                                .frame(width: 32, height: 32, alignment: .center)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct RoundButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            RoundButton(action: {}, text: "crypto", color1: .blue, color2: .green)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(red: 0.08, green: 0.09, blue: 0.17))
    }
}
