//
//  AnimatingLight.swift
//  JarTest
//
//  Created by Oleh Titov on 22.08.2022.
//

import SwiftUI

struct AnimatingLight: View {
    var size: Double
    var blurSize: Double
    var speed: Int
    var scaleAnimationDuration: Int
    @State var animate = false
    var body: some View {
        TimelineView(.animation) { context in
            let seconds = Calendar.current.component(.second, from: context.date)
            
            AngularGradient(colors: [Color(red: 0.33, green: 0.85, blue: 1.00), Color(red: 0.98, green: 0.46, blue: 0.66), Color(red: 0.11, green: 0.81, blue: 0.52), Color(red: 0.04, green: 0.67, blue: 0.89), Color(red: 1.00, green: 0.85, blue: 0.33)], center: .center)
                .blur(radius: blurSize)
                .mask(
                    Circle()
                      .frame(width: size, height: size)
                      .blur(radius: blurSize)
                    )
            .opacity(0.7)
            .offset(y: 20)
            .rotationEffect(Angle(degrees: Double(seconds)*10))
            .animation(.easeInOut, value: seconds)
        }
        .onAppear {
            self.animate.toggle()
        }
        .scaleEffect(animate ? 1.2 : 0.6)
        .animation(.easeIn(duration: 4).repeatForever(), value: animate)
    }
}

struct AnimatingLight_Previews: PreviewProvider {
    static var previews: some View {
        AnimatingLight(size: 300, blurSize: 50, speed: 10, scaleAnimationDuration: 3)
    }
}
