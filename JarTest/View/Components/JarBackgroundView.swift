//
//  JarBackgroundView.swift
//  JarTest
//
//  Created by Oleh Titov on 14.10.2022.
//

import SwiftUI

struct JarBackgroundView: View {
    var body: some View {
        ZStack {
            Image("grainBase")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .opacity(0.9)
                .ignoresSafeArea()
                .blendMode(.multiply)
            Group {
                Ellipse()
                    .fill(Color.purple)
                    .frame(width: 700, height: 600)
                    .rotationEffect(Angle(degrees: -45))
                    .blur(radius: 100)
                    .offset(x: -200, y: -50)
                Circle()
                    .fill(Color.blue)
                    .frame(width: 500, height: 500)
                    .blur(radius: 70)
                    .offset(x: 100, y: -200)
            }
            
            Group {
                Ellipse()
                    .fill(Color.green)
                    .frame(width: 700, height: 200)
                    .rotationEffect(Angle(degrees: -45))
                    .blur(radius: 70)
                    .offset(x: 200, y: 150)
                    .blendMode(.overlay)
                Circle()
                    .fill(Color.yellow)
                    .frame(width: 300, height: 300)
                    .blur(radius: 20)
                    .offset(x: 0, y: 0)
                    .blendMode(.overlay)
                Circle()
                    .fill(Color.green)
                    .frame(width: 200, height: 200)
                    .blur(radius: 70)
                    .offset(x: 140, y: -300)
                    .blendMode(.overlay)
            }
            
            
                
//                .blendMode(.multiply)

            
//            Color.clear
//                .background(.thinMaterial)
//                .ignoresSafeArea()
//                .blendMode(.overlay)
            Color.clear
                .background(.thickMaterial)
                .ignoresSafeArea()
            Image("grainBase")
                .resizable()
                .aspectRatio(contentMode: .fill)
//                .opacity(0.9)
                .ignoresSafeArea()
                .blendMode(.hardLight)
//            Image("noise")
//                .resizable(resizingMode: .tile)
//                .ignoresSafeArea()
//                .opacity(1)
//                .blendMode(.multiply)
        }
        .frame(width: UIScreen.main.bounds.size.width)
    }
}

struct JarBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            JarBackgroundView()
                .preferredColorScheme(.light)
            JarBackgroundView()
                .preferredColorScheme(.dark)
        }
    }
}
