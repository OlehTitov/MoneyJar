//
//  OnboardingJar.swift
//  JarTest
//
//  Created by Oleh Titov on 20.08.2022.
//

import SwiftUI

struct OnboardingJar: View {
    @State var animate = false
    var body: some View {
        VStack(spacing: 12) {
            VStack {
                ZStack {
                    //Gold
                    VStack {
                        TransactionListItem(image: "", name: "Gold bar", assetType: "Commodity", quantity: "1.24", isCommodity: true, color: .red)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                    .frame(width: 300)
                    .background(Color(red: 0.24, green: 0.27, blue: 0.47).opacity(0.5))
                    .background(.thinMaterial)
                    .cornerRadius(60)
                    .offset(x: animate ? -110 : 280, y: 0)
                    .animation(.easeInOut(duration: 3), value: animate)
                    
                    Circle()
                        .fill(Color(red: 0.56, green: 0.49, blue: 0.68))
                        .frame(width: 320, height: 230, alignment: .center)
                        .blur(radius: 60, opaque: false)
                        .opacity(0.6)
                        .offset(y: 20)
                    
                    
                    JarWithCoinsView(progress: 85.7, jarWidth: 250, coinsWidth: 220, frameHeight: 300)
                        .shadow(color: Color(red: 0.24, green: 0.27, blue: 0.47), radius: 12, x: 2, y: 4)
                    //USD
                    VStack {
                        TransactionListItem(image: "USD", name: "US Dollar", assetType: "Currency", quantity: 100.00.format(with: .usd), isCommodity: false)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                    .frame(width: 300)
                    .background(Color(red: 0.24, green: 0.27, blue: 0.47).opacity(0.3))
                    .background(.thinMaterial)
                    .cornerRadius(60)
                    .offset(x: animate ? 220 : -380, y: -40)
                    .shadow(color: Color(red: 0.24, green: 0.27, blue: 0.47), radius: 12, x: 2, y: 4)
                    .animation(.easeInOut(duration: 3), value: animate)
                    //Crypto
                    VStack {
                        TransactionListItem(image: "BTC", name: "Bitcoin", assetType: "Crypto", quantity: "1.24", isCommodity: false)
                            .padding(.horizontal)
                            .padding(.vertical, 6)
                    }
                    .frame(width: 300)
                    .background(Color(red: 0.24, green: 0.27, blue: 0.47).opacity(0.3))
                    .background(.ultraThinMaterial)
                    .cornerRadius(60)
                    .offset(x: animate ? 60 : -250, y: 90)
                    .shadow(color: .black.opacity(0.5), radius: 12, x: 2, y: 4)
                    .animation(.easeInOut(duration: 4), value: animate)
                }
                VStack {
                    Text("Multi-asset financial goal tracker")
                        .foregroundColor(.white)
                        .font(Font.system(size: 36, weight: .black, design: .default))
                        .multilineTextAlignment(.center)
                    VStack(alignment: .leading, spacing: 24) {
                        Text("Saving money for a big purchase? Keeping money in several assets like currencies, gold bar or coins, or may be crypto?")
                            
                        Text("Instantly check your progress relative to your base curency")
                            
                        Text("It is secure to log your assets into the Jar since all your data lives on your device only. We do not keep any data on any server.")
                            
                    }
                    .padding()
                    .foregroundColor(.white)
                    Spacer()
                    Button {
                        print("hello")
                    } label: {
                        Text("Get started")
                    }

                }
//                .padding(.horizontal, 12)
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .background(Color(red: 0.08, green: 0.09, blue: 0.17))
        }
        .onAppear {
            self.animate = true
        }
    }
}

struct OnboardingJar_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingJar()
    }
}
