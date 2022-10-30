//
//  WelcomeToJar.swift
//  JarTest
//
//  Created by Oleh Titov on 18.06.2022.
//

import SwiftUI

struct WelcomeToJar: View {
    @EnvironmentObject private var settingsStore : SettingsStore
    @State var animate = false
    @State var isCreateJarPressed = false
    var cardBackground = Color(UIColor.secondarySystemBackground)
    var cardCornerRadius: CGFloat = 12
    var body: some View {
        VStack {
            //When user presses button we show next view
            if isCreateJarPressed {
                ConfigureJar()
            } else {
                //Content
                ZStack {
                    UltimateGradientView()
                    VStack {
                        jarWithAssetChips
                        
                        bottomCardWithTextAndButton
                    }
                    .ignoresSafeArea()
                    .onAppear {
                        self.animate = true
                    }
                }
            }
        }
        //Set initial values for Sound and Haptics settings
        .task {
            settingsStore.initialSetup()
        }
    }
    func buttonTapped() {
        self.isCreateJarPressed = true
    }
    
    var jarWithAssetChips: some View {
        ZStack {
            makeMovingElement(image: "", name: "Gold bar", type: "Commodity", isCommodity: true, quantity: "10 oz", bgrdOpacity: 0.6, offsetStart: 400, offsetFinish: -120, offsetY: 0, duration: 2, delay: 0.4)
            
            JarShadow(width: 240, height: 40, blurRadius: 16, opacity: 0.4)
                .offset(y:140)
            
            JarWithCoinsView(progress: 85.7, jarWidth: 250, coinsWidth: 220, frameHeight: 300)
                .offset(y: animate ? 0 : -200)
                .animation(.interactiveSpring(), value: animate)
            
            makeMovingElement(image: "USD", name: "US Dollar", type: "Currency", isCommodity: false, quantity: Double(100.00).format(with: .usd), bgrdOpacity: 0.4, offsetStart: -400, offsetFinish: 150, offsetY: -40, duration: 2, delay: 0.6)
            
            makeMovingElement(image: "BTC", name: "Bitcoin", type: "Crypto", isCommodity: false, quantity: "1.24", bgrdOpacity: 0.3, offsetStart: -400, offsetFinish: 60, offsetY: 90, duration: 2, delay: 0.8)
        }
        .padding(40)
        .padding(.vertical)
    }
    
    var bottomCardWithTextAndButton: some View {
        ZStack {
            CustomCorner(corners: [.topLeft, .topRight], radius: cardCornerRadius)
                .fill(cardBackground)
            VStack {
                VStack(spacing: 12) {
                    VStack(alignment: .center, spacing: 24) {
                        Text("Multi-asset savings tracker")
                            .font(.customTitleFont)
                        Text("Set your financial goal. Add different assets and currencies to see how your jar is filling.")
                            .font(.customHeadlineFont)
                    }
                    .multilineTextAlignment(.center)
                    .padding(.top, 42)
                    .lineSpacing(8)
                    .padding(.horizontal, 36)
                }
                Spacer()
                Button("Get started") {
                    buttonTapped()
                }
                .buttonStyle(PrimaryButtonStyle())
                .padding(.bottom)
            }
        }
        .offset(y: animate ? 0 : 500)
        .animation(.interactiveSpring(), value: animate)
    }
    
    func makeMovingElement(image: String,
                           name: String,
                           type: String,
                           isCommodity: Bool,
                           quantity: String,
                           bgrdOpacity: Double,
                           offsetStart: Double,
                           offsetFinish: Double,
                           offsetY: Double,
                           duration: Double,
                           delay: Double) -> some View {
        VStack {
            TransactionListItem(image: image,
                                name: name,
                                assetType: type,
                                quantity: quantity,
                                isCommodity: isCommodity,
                                color: .red)
                .padding(.horizontal)
                .padding(.vertical, 6)
        }
        .frame(width: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(60)
        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 2)
        .offset(x: animate ? offsetFinish : offsetStart, y: offsetY)
        .animation(.easeOut(duration: duration).delay(delay), value: animate)
    }
}

struct WelcomeToJar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeToJar()
                .preferredColorScheme(.light)
                .environmentObject(SettingsStore())
            WelcomeToJar()
                .preferredColorScheme(.dark)
                .environmentObject(SettingsStore())
        }
    }
}
