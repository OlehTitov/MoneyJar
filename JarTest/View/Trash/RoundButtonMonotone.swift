//
//  RoundButtonMonotone.swift
//  JarTest
//
//  Created by Oleh Titov on 28.08.2022.
//

import SwiftUI

struct RoundButtonMonotone: View {
    var action : () -> Void
    var text : String
    var color1: Color
    var color2: Color
    var body: some View {
        ZStack {
            Button(action: action) {
                HStack {
                    Circle()
                        .strokeBorder(.white)
//                        .fill(Color.clear)
                        
                        .frame(width: 64, height: 64, alignment: .center)
                        .overlay {
                            Image(text)
                                .resizable()
                                .frame(width: 36, height: 36, alignment: .center)
                        }
                }
            }
            .padding(.horizontal)
        }
    }
}

struct RoundButtonMonotone_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Group {
                RoundButtonMonotone(action: {}, text: "crypto", color1: .blue, color2: .green)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.turquoiseBlue)
    }
}
