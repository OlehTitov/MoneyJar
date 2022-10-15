//
//  WelcomeToJar.swift
//  JarTest
//
//  Created by Oleh Titov on 18.06.2022.
//

import SwiftUI

struct WelcomeToJar: View {
    @StateObject var viewModel : WelcomeToJarViewModel
    var body: some View {
        VStack {
            //When user presses button we show next view
            if viewModel.isCreateJarPressed {
                ConfigureJar().navigationBarHidden(true)
            } else {
                Content(viewModel: viewModel)
            }
        }
    }
}

struct WelcomeToJar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            WelcomeToJar(viewModel: WelcomeToJarViewModel())
                .preferredColorScheme(.light)
            WelcomeToJar(viewModel: WelcomeToJarViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

extension WelcomeToJar {
    struct Content: View {
        @StateObject var viewModel : WelcomeToJarViewModel
        
        var title = "Multi-asset financial goal tracker"
        var paragraph1 = "Set your financial goal. Save different assets elsewhere and log it here. See how your jar is filling."
        var paragraph2 = "Save in Bitcoin, gold coins or bars, world currencies and instantly see the amount in your home currency."
        var paragraph3 = "You own the data, nothing is stored on server."
        var body: some View {
            ZStack {
                BackgroundView()
                ScrollView(.vertical, showsIndicators: false) {
                    ZStack {
                        makeMovingElement(image: "", name: "Gold bar", type: "Commodity", isCommodity: true, quantity: "10 oz", bgrdOpacity: 0.6, offsetStart: -110, offsetFinish: 280, offsetY: 0, duration: 3)
                        
                        JarShadow(width: 240, height: 40, blurRadius: 16, opacity: 0.4)
                            .offset(y:140)
                        
                        JarWithCoinsView(progress: 85.7, jarWidth: 250, coinsWidth: 220, frameHeight: 300)
                        
                        makeMovingElement(image: "USD", name: "US Dollar", type: "Currency", isCommodity: false, quantity: 100.currencyFormatter(with: "en_US", code: "USD"), bgrdOpacity: 0.4, offsetStart: 220, offsetFinish: -380, offsetY: -40, duration: 3)
                        
                        makeMovingElement(image: "BTC", name: "Bitcoin", type: "Crypto", isCommodity: false, quantity: "1.24", bgrdOpacity: 0.3, offsetStart: 60, offsetFinish: -250, offsetY: 90, duration: 4)
                    }
                    titleAndDescription()
                }
                .safeAreaInset(edge: .bottom, content: {
                    Button (action: {viewModel.createPressed()}, label: {})
                        .buttonStyle(MyButtonStyle(title: "Get Started"))
                }
                )
                .onAppear {
                    viewModel.startAnimation()
            }
            }
        }
        
        func titleAndDescription() -> some View {
            VStack(spacing: 12) {
                VStack(spacing: -8) {
                    Text("Multi-asset financial goal tracker")
//                        .font(.system(size: 38, weight: .bold, design: .rounded))
                        .font(Font.custom("RobotoMono-Bold", size: 28))
                        .multilineTextAlignment(.center)
                    
                }
                .padding(.vertical)
                .padding(.top, 38)
                
                VStack(alignment: .leading, spacing: 24) {
                    Text(paragraph1)
                    Text(paragraph2)
                    Text(paragraph3)
                }
//                .font(Font.custom("RobotoMono-Medium", size: 18))
//                .font(.system(.headline, design: .rounded))
//                .font(.system(size: 20))
                .lineSpacing(6)
                .padding(.horizontal, 24)
//                .foregroundColor(.white)
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
            .shadow(color: Color("cloudBurst").opacity(0.4), radius: 8, x: 0, y: 2)
            .offset(x: viewModel.animate ? offsetStart : offsetFinish, y: offsetY)
            .animation(.easeInOut(duration: duration), value: viewModel.animate)
        }
    }
}

