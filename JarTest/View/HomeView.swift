//
//  ContentView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.05.2022.
//

import SwiftUI
import Subsonic

struct HomeView: View {
    @EnvironmentObject private var stateController: StateController
    @StateObject var viewModel = ViewModel()
    var body: some View {
        Content2()
            .task {
                if stateController.account.rates.isEmpty {
                    await stateController.getLatestRates()
                }
                stateController.calculateBalance()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .environmentObject(StateController.dummyData())
                .environmentObject(SettingsStore())
                .preferredColorScheme(.dark)
            HomeView()
                .environmentObject(StateController.dummyData())
                .environmentObject(SettingsStore())
                .preferredColorScheme(.light)
        }
    }
}

extension HomeView {
    struct Content2: View {
        @EnvironmentObject private var stateController: StateController
        @EnvironmentObject private var settingsStore : SettingsStore
        @Environment(\.colorScheme) var colorScheme
        @AppStorage(storageKeys.greetingSoundPlayed.rawValue) var greetingSoundPlayed = false
        @ObservedObject var player = AudioPlayer(name: "coins-falling", withExtension: "wav")
        @State var mainStack: [NavigationType] = []
        @State var presentSheet = false
        @State var animateButton = false
        @State var awardForPresentation = Award(id: 0, name: "Hello!", image: "1_engage", status: .completed, presented: false, detailedText: "sample detail text")
        //Check sound settings
//        var soundIsOn = UserDefaults.standard.bool(forKey: storageKeys.soundIsOn.rawValue)
        var body: some View {
            ZStack {
                NavigationStack(path: $mainStack) {
//                    ZStack {
//                        BackgroundView()
//                        VStack(spacing: 32) {
//                            goalAmount()
//                            JarWithCoinsView(progress: stateController.account.progress)
//                            newTotalAmount(size: 50, decimalSize: 32)
//                            fillJarButton()
//                        }
//                    }
                    ZStack {
//                        Color(uiColor: .systemGray3)
//                        BackgroundView()
                        Image("ultimateGradient")
                            .resizable()
                            .ignoresSafeArea()
                        VStack {
                            JarWithCoinsView(progress: stateController.account.progress)
                                .padding(.bottom, 80)
                                .padding(.top, 40)
                            VStack(alignment: .leading) {
                                fillJarButton()
                                    .offset(y: -70)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Balance".uppercased())
                                        .foregroundColor(.secondary)
                                        .bold()
                                    newTotalAmount(size: 50, decimalSize: 32)
                                }
                                Spacer()
                                
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(Color(uiColor: .secondarySystemBackground))
                        }
                    }
                    .onAppear {
                        //Play greeting sound only when Jar is freshly created
                        playGreetingSound()
                        //Check if there are any new awards to display
//                        checkAwards()
                    }
                    .navigationTitle(stateController.account.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.hidden, for: .navigationBar)
                    .toolbarBackground(Color.clear, for: .navigationBar)
                    .toolbar {
                        Button {
                            mainStack.append(.awards)
                        } label: {
                            Image(systemName: "gift")
                        }
                    }
                    .navigationDestination(for: NavigationType.self, destination: { value in
                        switch value {
                        ///Navigation happens here
                            //passing mainStack to views so later I could pop to root
                        case .selectAsset: SelectAssetTypeView(mainStack: $mainStack)
                        case .awards: AwardsView()
                        }
                    })
                }
                
                .sheet(isPresented: $presentSheet, onDismiss: {
                    if !stateController.account.awardsForPresentation.isEmpty {
                        DispatchQueue.main.async {
                            stateController.markAwardAsPresented(award: award)
                        }
                    }
                    
                }) {
                    AwardUnlockedSheet(show: $presentSheet, award: award)
                    .presentationDetents([.medium])
                }
            }
        }
        
        func newTotalAmount(size: CGFloat, decimalSize: CGFloat) -> some View {
            RollingCounterAnimation(initialBalance: stateController.account.balanceBeforeChange, currentBalance: stateController.account.balance, fontSize: size, decimaSize: decimalSize, currencyCode: stateController.account.baseCurrency.rawValue, currencyLocale: stateController.account.baseCurrency.locale)
                .minimumScaleFactor(0.5)
//                .frame(height: 100)
//                .padding(.horizontal)
                
        }
        
        func goalAmount() -> some View {
            HStack {
                Image(systemName: "flag")
                    .font(.headline.bold())
                Text(Double(stateController.account.goalAmount).currencyFormatter(with: stateController.account.baseCurrency.locale, code: stateController.account.baseCurrency.rawValue))
                    .font(Font.custom("RobotoMono-Medium", size: 20))
            }
        }
        
        func fillJarButton() -> some View {
            HStack(spacing: 20) {
                Button(action: {
                    mainStack.append(.selectAsset)
                    greetingSoundPlayed = true
                }) {
                    VStack {
                        if colorScheme == .dark {
                            Image(systemName: "arrow.down.to.line")
                                .foregroundColor(Color.primary)
                                .font(.title3)
                                .padding()
                                .overlay {
                                    Circle()
                                        .strokeBorder(Color.primary, lineWidth: 2)
                                }
                        } else {
                            Image(systemName: "arrow.down.to.line")
                                .foregroundColor(Color("x11Gray"))
                                .font(.title3)
                                .padding()
                                .background(Color.primary)
                                .clipShape(Circle())
                        }
                    }
                }
                .accessibilityLabel("Add assets")
                Text("Add assets")
                    .font(.title3)
                    .fontWeight(.bold)
                    .frame(width: 70)
                Spacer()
            }
            .padding()
            .frame(width: 220)
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.1), radius: 8)
            
        }
        
        func fillJarButtonDarkMode() -> some View {
            Button(action: {
                mainStack.append(.selectAsset)
                greetingSoundPlayed = true
            }) {
                Image(systemName: "arrow.down.to.line")
                    .foregroundColor(Color("x11Gray"))
                    .font(.title)
                    .padding()
                    .background(Color.primary)
                    .clipShape(Circle())
            }
            .accessibilityLabel("Fill the jar")
        }
        
        func playGreetingSound() {
            if !greetingSoundPlayed {
                play(sound: "success.wav")
                greetingSoundPlayed = true
            }
        }
        
        func checkAwards() {
            stateController.checkAllAwards()
            if stateController.account.awardsForPresentation.count != 0 {
                
                //Show award with delay because there might be a sound of fallings coins and balance amount animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.presentSheet = true
                }
            }
        }
        
        var award: Award {
            if stateController.account.awardsForPresentation.isEmpty {
                return Award(id: 0, name: "Dummy", image: "1_engage", status: .completed, presented: false, detailedText: "")
            } else {
                return stateController.account.awardsForPresentation[0]
            }
        }
    }
}

extension HomeView {
    class ViewModel: ObservableObject {
        @Published var selection: Int? = nil
        @Published var showAddAssetOptions = false
        
        func setNavigationTo(selection: Int) {
            self.selection = selection
        }
        
        func showingAddAssetOptions() {
            showAddAssetOptions = true
        }
    }
}

enum NavigationType: String, Hashable {
    case selectAsset = "Select asset"
    case awards = "Your awards"
}




