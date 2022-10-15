//
//  IconsLineWidthTest.swift
//  JarTest
//
//  Created by Oleh Titov on 28.09.2022.
//

import SwiftUI

struct IconsLineWidthTest: View {
    var iconsColor: Color
    var opacity: Double
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: 200, height: 100)
            .overlay{
                ZStack {
                    dollar2()
                        .rotationEffect(.degrees(6))
                        .offset(x: -96, y: 26)
                    banknote1()
                        .rotationEffect(.degrees(-6))
                        .offset(x: -84, y: -24)
                    house2()
                        .offset(x: -16, y: -50)
                    dollar1()
                        .rotationEffect(.degrees(6))
                        .offset(x: 46, y: -40)
                    banknote1()
                        .rotationEffect(.degrees(-6))
                        .offset(x: 116, y: -24)
                    house2()
                        .offset(x: -16, y: 50)
                    dollar1()
                        .rotationEffect(.degrees(6))
                        .offset(x: 46, y: 60)
                    dollar2()
                        .rotationEffect(.degrees(6))
                        .offset(x: 104, y: 26)
                    banknote2()
                }
            }
            .clipped()
            .opacity(opacity)
    }
    
    func dollar1() -> some View {
        Image(systemName: "dollarsign.circle")
            .foregroundColor(iconsColor)
            .font(.largeTitle.weight(.regular))
            .imageScale(.large)
    }
    
    func dollar2() -> some View {
        Image(systemName: "dollarsign.circle")
            .foregroundColor(iconsColor)
            .font(.title.weight(.medium))
            .imageScale(.medium)
    }
    
    func dollar3() -> some View {
        Image(systemName: "dollarsign.circle")
            .foregroundColor(iconsColor)
            .font(.title3.weight(.semibold))
            .imageScale(.medium)
    }
    
    func house1() -> some View {
        Image(systemName: "house")
            .foregroundColor(iconsColor)
            .font(.largeTitle.weight(.regular))
            .imageScale(.large)
    }
    
    func house2() -> some View {
        Image(systemName: "house")
            .foregroundColor(iconsColor)
            .font(.title.weight(.medium))
            .imageScale(.medium)
    }
    
    func house3() -> some View {
        Image(systemName: "house")
            .foregroundColor(iconsColor)
            .font(.title3.weight(.semibold))
            .imageScale(.medium)
    }
    
    func banknote1() -> some View {
        Image(systemName: "banknote")
            .foregroundColor(iconsColor)
            .font(.largeTitle.weight(.regular))
            .imageScale(.large)
    }
    
    func banknote2() -> some View {
        Image(systemName: "banknote")
            .foregroundColor(iconsColor)
            .font(.title.weight(.medium))
            .imageScale(.medium)
    }
    
    func banknote3() -> some View {
        Image(systemName: "banknote")
            .foregroundColor(iconsColor)
            .font(.title3.weight(.semibold))
            .imageScale(.medium)
    }
}

struct IconsLineWidthTest_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color("spearMint")
            IconsLineWidthTest(iconsColor: .seaGreen, opacity: 0.5)
        }
    }
}
