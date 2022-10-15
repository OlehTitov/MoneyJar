//
//  ConfigureJar.swift
//  JarTest
//
//  Created by Oleh Titov on 18.06.2022.
//

import SwiftUI
import SwiftUIPager

struct ConfigureJar: View {
    @StateObject var vm = ViewModel()
    var body: some View {
        VStack {
            if vm.nextView {
                SetAmount(selectedCurrency: vm.selectedCurrency, jarName: vm.name)
            } else {
                Content(vm: vm)
            }
        }
    }
}

struct ConfigureJar_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ConfigureJar()
                .environmentObject(
                    StateController(
                        storageController: MockStorageController(),
                        exchangeClient: MockExchangeClient(),
                        currencyConverter: CurrencyConverter(), awardsManager: AwardsManager()
                    )
                )
            .preferredColorScheme(.light)
            ConfigureJar()
                .environmentObject(
                    StateController(
                        storageController: MockStorageController(),
                        exchangeClient: MockExchangeClient(),
                        currencyConverter: CurrencyConverter(), awardsManager: AwardsManager()
                    )
                )
            .preferredColorScheme(.dark)
        }
    }
}

extension ConfigureJar {
    struct Content: View {
        @StateObject var vm : ViewModel
        
        let headline = "What are you saving for?"
        let buttonText = "Create Jar"
        let jarImageName = "Jar-4"
        let pagerItemSpacing : CGFloat = 0
        let pagerInteractiveScale : Double = 0.7
        let pagerItemAspectRatio : Double = 0.8
        
        var body: some View {
            ZStack {
                BackgroundView()
                VStack(spacing: 12) {
                    ZStack {
                        Pager(page: vm.page, data: vm.currencies, id: \.self) { item in
                            self.pageView(item)
                                .padding()
                        }
                        .multiplePagination()
                        .itemSpacing(pagerItemSpacing)
                        .bounces(true)
                        .interactive(scale: pagerInteractiveScale)
                        .draggingAnimation(.interactive)
                        .itemAspectRatio(pagerItemAspectRatio, alignment: .center)
                        .onPageChanged({ (newIndex) in
                            vm.updateSelectedCurrencyWith(newIndex: newIndex)
                        })
                        .onAppear {
                            vm.scrollPagerToNextOption()
                        }
                    }
                        
                    VStack(spacing: 12) {
                        Text(headline)
                            .font(Font.custom("RobotoMono-Medium", size: 18))
                        LegacyTextField(
                            text: $vm.name,
                            isFirstResponder: $vm.isFirstResponder,
                            keyboard: .alphabet
                        )
                        Spacer()
                        Button(action: {vm.nextPressed()}, label: {})
                            .disabled(vm.checkButtonDisabled())
                            .buttonStyle(MyButtonStyle(title: buttonText))
                            .padding(.bottom)
                    }
                }
            }
        }
        func pageView(_ item: ForeignCurrency) -> some View {
            VStack {
                Spacer()
                ZStack {
                    JarShadow(width: 150, height: 18, blurRadius: 6, opacity: 0.2)
                        .offset(y:116)
                    Image(jarImageName)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                    ZStack {
                        Circle()
                            .strokeBorder(item.color, lineWidth: 3)
                            .frame(width: 80, height: 80)
                        Text(item.rawValue)
                            .font(.title2)
                            .foregroundColor(.white)
                            .padding(24)
                            .background(
                                Circle()
                                    .fill(Color.black)
                                    .frame(width: 68, height: 68)
                        )
                    }
                }
                Spacer()
            }
        }
    }
}

extension ConfigureJar {
    class ViewModel : ObservableObject {
        @Published var selectedCurrency = ForeignCurrency.eur
        @Published var name = "For "
        @Published var page: Page = .first()
        @Published var isFirstResponder : Bool = true
        @Published var nextView: Bool = false
        
        var currencies: [ForeignCurrency] = [.usd, .eur, .pln]
        
        func checkButtonDisabled() -> Bool {
            let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty || trimmed == "For" || trimmed == "Fo" || trimmed == "F"
        }
        
        func updateSelectedCurrencyWith(newIndex : Int) {
            selectedCurrency = currencies[newIndex]
        }
        
        func nextPressed() {
            self.nextView = true
            self.isFirstResponder = false
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        func scrollPagerToNextOption() {
            self.page.update(.next)
        }
    }
}


