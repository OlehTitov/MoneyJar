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
    var title = "Multi-asset savings tracker"
    var paragraph1 = "Set your financial goal. Add different assets and currencies to see how your jar is filling."
    var paragraph2 = "Save in Bitcoin, gold coins or bars, world currencies and instantly see the amount in your home currency."
    var paragraph3 = "You own the data, nothing is stored on server."
    var buttonTitle = "Get started"
    var body: some View {
        VStack {
            //When user presses button we show next view
            if self.isCreateJarPressed {
                ConfigureJar().navigationBarHidden(true)
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
            makeMovingElement(image: "", name: "Gold bar", type: "Commodity", isCommodity: true, quantity: "10 oz", bgrdOpacity: 0.6, offsetStart: -110, offsetFinish: 280, offsetY: 0, duration: 3)
            
            JarShadow(width: 240, height: 40, blurRadius: 16, opacity: 0.4)
                .offset(y:140)
            
            JarWithCoinsView(progress: 85.7, jarWidth: 250, coinsWidth: 220, frameHeight: 300)
            
            makeMovingElement(image: "USD", name: "US Dollar", type: "Currency", isCommodity: false, quantity: 100.currencyFormatter(with: "en_US", code: "USD"), bgrdOpacity: 0.4, offsetStart: 220, offsetFinish: -380, offsetY: -40, duration: 3)
            
            makeMovingElement(image: "BTC", name: "Bitcoin", type: "Crypto", isCommodity: false, quantity: "1.24", bgrdOpacity: 0.3, offsetStart: 60, offsetFinish: -250, offsetY: 90, duration: 4)
        }
        .padding(40)
    }
    
    var bottomCardWithTextAndButton: some View {
        ZStack {
            CustomCorner(corners: [.topLeft, .topRight], radius: cardCornerRadius)
                .fill(cardBackground)
            VStack {
                VStack(spacing: 12) {
                    VStack(spacing: -8) {
                        Text(title)
                            .font(.customTitleFont)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        Text(paragraph1)
                        Text(paragraph2)
                        Text(paragraph3)
                    }
                    .font(.customHeadlineFont)
                    .lineSpacing(6)
                    .padding(.horizontal, 24)
                }
                Spacer()
                Button (action: {buttonTapped()}, label: {})
                    .buttonStyle(MyButtonStyle(title: buttonTitle))
                    .padding(.bottom)
            }
        }
    }
    
    func makeMovingElement(image: String, name: String, type: String, isCommodity: Bool, quantity: String, bgrdOpacity: Double, offsetStart: Double, offsetFinish: Double, offsetY: Double, duration: Double) -> some View {
        VStack {
            TransactionListItem(image: image, name: name, assetType: type, quantity: quantity, isCommodity: isCommodity, color: .red)
                .padding(.horizontal)
                .padding(.vertical, 6)
        }
        .frame(width: 300)
        .background(.ultraThinMaterial)
        .cornerRadius(60)
        .shadow(color: Color.black.opacity(0.4), radius: 8, x: 0, y: 2)
        .offset(x: animate ? offsetStart : offsetFinish, y: offsetY)
        .animation(.easeInOut(duration: duration), value: animate)
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
