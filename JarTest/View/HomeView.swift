//
//  ContentView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.05.2022.
//

import SwiftUI
import Subsonic

struct HomeView: View {
    @EnvironmentObject private var model: Model
    var body: some View {
        Content2()
            .task {
                if model.account.rates.isEmpty {
                    await model.getLatestRates()
                }
                model.calculateBalance()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            HomeView()
                .environmentObject(Model.dummyData())
                .environmentObject(SettingsStore())
                .preferredColorScheme(.dark)
            HomeView()
                .environmentObject(Model.dummyData())
                .environmentObject(SettingsStore())
                .preferredColorScheme(.light)
        }
    }
}

extension HomeView {
    struct Content2: View {
        @EnvironmentObject private var model: Model
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
                    ZStack {
                        UltimateGradientView()
                        VStack {
                            JarWithCoinsView(progress: model.account.progress)
                                .padding(.bottom, 60)
                                .padding(.top, 40)
                            ScrollView(.vertical, showsIndicators: false) {
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Balance")
                                        .foregroundColor(.secondary)
                                        .font(.customBodyFont)
                                    newTotalAmount(size: 50, decimalSize: 32)
                                }
                                .padding(.vertical)
                                .padding(.top, 24)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                VStack(alignment: .leading, spacing: 16) {
                                    Text(model.account.name)
                                        .foregroundColor(.secondary)
                                        .font(.customBodyFont)
                                    CustomProgressView(progress: model.account.progress/100)
                                    HStack {
                                        Text("\(model.account.progress.toStringWithDecimalIfNeeded()) %")
                                        Spacer()
                                        goalAmount()
                                    }
                                    .font(.customHeadlineFont)
//                                    .foregroundColor(.secondary)
                                }
                                .padding(.vertical, 24)
//                                .padding()
//                                .padding(.vertical, 8)
//                                .background(
//                                    RoundedRectangle(cornerRadius: 24)
//                                        .strokeBorder(.tertiary, style: StrokeStyle(lineWidth: 1))
//                                )
//                                .padding(.vertical)
                            }
                            .frame(maxHeight: .infinity)
                            .padding()
                            .background(Color(uiColor: .secondarySystemBackground))
                            .overlay {
                                VStack {
                                    fillJarButton()
                                }
                                .frame(maxHeight: .infinity, alignment: .top)
                                .offset(y: -50)
                            }
                        }
                        Button {
                            mainStack.append(.awards)
                        } label: {
                            Image(systemName: "gift")
                                .padding()
                                .background(Color(UIColor.secondarySystemBackground))
                                .clipShape(Circle())
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .frame(maxHeight: .infinity, alignment: .top)
                    }
                    .onAppear {
                        //Play greeting sound only when Jar is freshly created
                        playGreetingSound()
                        //Check if there are any new awards to display
                        checkAwards()
                    }
                    .navigationTitle(model.account.name)
                    .toolbar(.hidden, for: .navigationBar)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbarBackground(.hidden, for: .navigationBar)
                    .toolbarBackground(Color.clear, for: .navigationBar)
                    .toolbar {
                        Button {
                            mainStack.append(.awards)
                        } label: {
                            Image(systemName: "gift")
                                .padding(8)
                                .background(Color(UIColor.secondarySystemBackground))
                                .clipShape(Circle())
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
                    if !model.account.awardsForPresentation.isEmpty {
                        DispatchQueue.main.async {
                            model.markAwardAsPresented(award: award)
                        }
                    }
                    
                }) {
                    AwardUnlockedSheet(show: $presentSheet, award: award)
                    .presentationDetents([.medium])
                }
            }
        }
        
        func newTotalAmount(size: CGFloat, decimalSize: CGFloat) -> some View {
            RollingCounterAnimation(initialBalance: model.account.balanceBeforeChange, currentBalance: model.account.balance, fontSize: size, decimaSize: decimalSize)
                .minimumScaleFactor(0.5)
        }
        
        func goalAmount() -> some View {
            HStack {
                Image(systemName: "flag")
                Text(Double(model.account.goalAmount).format(with: model.account.baseCurrency))
            }
        }
        
        func fillJarButton() -> some View {
            Button(action: {
                mainStack.append(.selectAsset)
                greetingSoundPlayed = true
            }) {
                HStack(spacing: 20) {
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
                    Text("Add assets")
                        .font(.customButtonTextFont)
//                        .fontWeight(.bold)
                        .frame(width: 70)
                    Spacer()
                }
            }
            .accessibilityLabel("Add assets")
            .buttonStyle(.plain)
            .padding()
            .frame(width: 220)
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(24)
            .shadow(color: Color.black.opacity(0.1), radius: 8)
        }
        
        func playGreetingSound() {
            if !greetingSoundPlayed {
                play(sound: "success.wav")
                greetingSoundPlayed = true
            }
        }
        
        func checkAwards() {
            model.checkAllAwards()
            if model.account.awardsForPresentation.count != 0 {
                
                //Show award with delay because there might be a sound of fallings coins and balance amount animation
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                        self.presentSheet = true
                }
            }
        }
        
        var award: Award {
            if model.account.awardsForPresentation.isEmpty {
                return Award(id: 0, name: "Dummy", image: "1_engage", status: .completed, presented: false, detailedText: "")
            } else {
                return model.account.awardsForPresentation[0]
            }
        }
    }
}

enum NavigationType: String, Hashable {
    case selectAsset = "Select asset"
    case awards = "Your awards"
}




