//
//  ConfigureJar.swift
//  JarTest
//
//  Created by Oleh Titov on 18.06.2022.
//

import SwiftUI
import SwiftUIPager

struct ConfigureJar: View {
    @State var nextView: Bool = false
    @State var selectedCurrency: ForeignCurrency = .eur
    @State var name: String = "For "
    var body: some View {
        VStack {
            if nextView {
                SetAmount(
                    selectedCurrency: selectedCurrency,
                    jarName: name)
            } else {
                Content(
                    selectedCurrency: $selectedCurrency,
                    name: $name, nextView: $nextView)
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
        @Binding var selectedCurrency: ForeignCurrency
        @Binding var name: String
        @State var page: Page = .first()
        @State var isFirstResponder : Bool = true
        @Binding var nextView: Bool
        
        let jarImageName = "Jar-4"
        let pagerItemSpacing : CGFloat = 0
        let pagerInteractiveScale : Double = 0.7
        let pagerItemAspectRatio : Double = 0.8
        
        var body: some View {
            ZStack {
                BackgroundView()
                VStack(spacing: 12) {
                    currencyJarSelection
                        .onAppear {
                            scrollPagerToNextOption()
                        }
                        
                    VStack(spacing: 12) {
                        Text("What are you saving for?")
                            .font(.customHeadlineFont)
                        LegacyTextField(
                            text: $name,
                            isFirstResponder: $isFirstResponder,
                            keyboard: .alphabet
                        )
                        Spacer()
                        Button("Create Jar") {
                            nextPressed()
                        }
                        .buttonStyle(PrimaryButtonStyle())
                        .disabled(checkButtonDisabled())
                        .padding(.bottom)
                    }
                }
            }
        }
        
        var currencyJarSelection: some View {
            Pager(page: page, data: ForeignCurrency.forInitialSelection, id: \.self) { item in
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
                updateSelectedCurrencyWith(newIndex: newIndex)
            })
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
                            .font(.customButtonTextFont)
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
        
        func updateSelectedCurrencyWith(newIndex : Int) {
            selectedCurrency = ForeignCurrency.forInitialSelection[newIndex]
        }
        
        func scrollPagerToNextOption() {
            self.page.update(.next)
        }
        
        func nextPressed() {
            self.nextView = true
            self.isFirstResponder = false
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        
        func checkButtonDisabled() -> Bool {
            let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
            return trimmed.isEmpty || trimmed == "For" || trimmed == "Fo" || trimmed == "F"
        }
    }
}
