//
//  JarWithFlag.swift
//  JarTest
//
//  Created by Oleh Titov on 26.08.2022.
//

import SwiftUI

struct JarWithFlag: View {
    var jarImage: String
    var jarHeight: CGFloat
    var jarIcon: String
    var color: Color
    var body: some View {
        ZStack {
            Image(jarImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: jarHeight)
                .padding()
            ZStack {
                Circle()
                    .strokeBorder(color, lineWidth: 3)
                    .frame(width: 80, height: 80)
                Image(systemName: "flag")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding(24)
                    .background(
                        Circle()
                            .fill(Color.black)
                            .frame(width: 68, height: 68)
                )
            }
        }
    }
}

struct JarWithFlag_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            JarWithFlag(jarImage: "Jar-4", jarHeight: 200, jarIcon: "flag.fill", color: .green)
        }
        .background(Color.mirage)
    }
}
