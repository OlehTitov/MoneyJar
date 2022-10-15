//
//  BackgroundTile.swift
//  JarTest
//
//  Created by Oleh Titov on 27.09.2022.
//

import SwiftUI

struct BackgroundTile: View {
    var iconsColor: Color
    var opacity: Double
    var body: some View {
        Rectangle()
            .fill(Color.clear)
            .frame(width: 160, height: 160)
            .overlay {
                ZStack {
                    //First part
                    Group {
                        Image("coins")
                            .scaleEffect(0.2)
                            .offset(x: -70, y: 40)
                        
                        Image("currency-gbp")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(10), anchor: .center)
                            .offset(x: -80, y: -10)
                            
                        Image("money")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(-20))
                            .offset(x: -70, y: -70)
                            
                        Image("currency-btc")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(5))
                            .offset(x: -20, y: -80)
                            
                        Image("vault")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(-30))
                            .offset(x: 30, y: -80)
                    }
                    
                    //Second halves
                    Group {
                        Image("coins")
                            .scaleEffect(0.2)
                            .offset(x: 90, y: 40)
                        
                        Image("currency-gbp")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(10), anchor: .center)
                            .offset(x: 80, y: -10)
                        
                        Image("money")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(-20))
                            .offset(x: -70, y: 90)
                        
                        Image("currency-btc")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(5))
                            .offset(x: -20, y: 80)
                        
                        Image("vault")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(-30))
                            .offset(x: 30, y: 80)
                    }
                    
                    //Third parts
                    Image("money")
                        .scaleEffect(0.2)
                        .rotationEffect(.degrees(-20))
                        .offset(x: 90, y: -70)
                    
                    //Whole icons
                    Group {
                        Image("coin-vertical")
                            .scaleEffect(0.2)
                            .offset(x: 50, y: -40)
                        
                        Image("currency-dollar-simple")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(-35))
                            .offset(x: 50, y: 40)
                        
                        Image("currency-eth")
                            .scaleEffect(0.2)
                            .offset(x: 16, y: 0)
                        
                        Image("currency-eur")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(35))
                            .offset(x: -20, y: 30)
                        
                        Image("wallet")
                            .scaleEffect(0.2)
                            .rotationEffect(.degrees(-20))
                            .offset(x: -36, y: -26)
                    }
                    
                    iconsColor
                        .blendMode(.sourceAtop)
                }
                .opacity(opacity)
            }
            .clipped()
            .ignoresSafeArea(.all)
    }
}

struct BackgroundTile_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundTile(iconsColor: .seaGreen, opacity: 0.5)
    }
}
