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
            makeMovingElement(image: "", name: "Gold bar", type: "Commodity", isCommodity: true, quantity: "10 oz", bgrdOpacity: 0.6, offsetStart: -110, offsetFinish: 280, offsetY: 0, duration: 3)
            
            JarShadow(width: 240, height: 40, blurRadius: 16, opacity: 0.4)
                .offset(y:140)
            
            JarWithCoinsView(progress: 85.7, jarWidth: 250, coinsWidth: 220, frameHeight: 300)
            
            makeMovingElement(image: "USD", name: "US Dollar", type: "Currency", isCommodity: false, quantity: Double(100.00).format(with: .usd), bgrdOpacity: 0.4, offsetStart: 220, offsetFinish: -380, offsetY: -40, duration: 3)
            
            makeMovingElement(image: "BTC", name: "Bitcoin", type: "Crypto", isCommodity: false, quantity: "1.24", bgrdOpacity: 0.3, offsetStart: 60, offsetFinish: -250, offsetY: 90, duration: 4)
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
                           duration: Double) -> some View {
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
