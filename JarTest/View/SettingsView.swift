//
//  SettingsView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.08.2022.
//

import SwiftUI
import MessageUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var stateController: StateController
    @State var navPath: NavigationPath = NavigationPath()
    @EnvironmentObject private var settingsStore: SettingsStore
    @State var selectedCurrency: ForeignCurrency
    @AppStorage(storageKeys.soundIsOn.rawValue) var soundIsOn = true
    //Mail settings
    @State var isShowingMailView = false
    @State var alertNoMail = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                BackgroundView()
                Form {
                    ///Jar Settings
                    Section(header: Text("Jar settings").font(Font.custom("RobotoMono-Medium", size: 16))) {
                        //Jar name and Goal amount
                        ForEach(SettingsRoute.general, id: \.self) { route in
                            NavigationLink(value: route) {
                                Label(route.rawValue, systemImage: route.icon)
                            }
                        }
                        //Base currency
                        Picker(selection: $selectedCurrency, label: Label("Base currency", systemImage: "dollarsign")) {
                            ForEach(ForeignCurrency.allCases, id: \.self) { currency in
                                Text(currency.longDescription)
                            }
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    ///General Settings
                    Section(header: Text("General").font(Font.custom("RobotoMono-Medium", size: 16))) {
                        //Sound settings
                        Label {
                            Toggle("Sound", isOn: $settingsStore.soundIsOn)
                                .tint(Color.accentColor)
                        } icon: {
                            Image(systemName: "music.note")
                        }
                        //Haptic settings
//                        Label {
//                            Toggle("Haptics", isOn: $settingsStore.hapticsIsOn)
//                                .tint(Color.accentColor)
//                        } icon: {
//                            Image(systemName: "hand.tap")
//                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    ///Get in touch
                    Section(header: Text("Get in touch").font(Font.custom("RobotoMono-Medium", size: 16))) {
                        //Email
                        Label {
                            HStack {
                                Text("Email")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                        } icon: {
                            Image(systemName: "envelope")
                        }
                        .onTapGesture {
                            MFMailComposeViewController.canSendMail() ? self.isShowingMailView.toggle() : self.alertNoMail.toggle()
                        }
                        .sheet(isPresented: $isShowingMailView) {
                            MailView(result: $result,
                                     recipients: ["oleg.titov81@gmail.com"],
                                     subject: "MoneyJar feedback")
                        }
                        .alert(isPresented: self.$alertNoMail) {
                            Alert(title: Text("Please setup your Mail app"))
                        }
                        //Rate in AppStore
                        Link(destination: URL(string: StateController.appStoreReviewLink)!) {
                            HStack {
                                Label("Rate in AppStore", systemImage: "star")
                                Spacer()
                                Image(systemName: "arrow.up.right")
                            }
                        }

                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    ///Other
                    Section(header: Text("Other").font(Font.custom("RobotoMono-Medium", size: 16))) {
                        NavigationLink(value: SettingsRoute.credits) {
                            Label(SettingsRoute.credits.rawValue, systemImage: SettingsRoute.credits.icon)
                        }
                    }
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
            }
            .navigationDestination(for: SettingsRoute.self, destination: { route in
                switch route {
                case .jarName: ChangeJarNameView(path: $navPath, jarName: stateController.account.name)
                case .changeGoalAmount: ChangeAmountView(path: $navPath)
                case .credits: CreditsView()
                }
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(colorScheme == .dark ? Color("shipCove") : Color("mint"), for: .navigationBar)
        }
        .onChange(of: selectedCurrency) { newValue in
            stateController.setBaseCurrency(newValue: newValue)
            stateController.calculateBalance()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedCurrency: .usd)
            .environmentObject(StateController.dummyData())
            .environmentObject(SettingsStore())
    }
}

enum SettingsRoute: String, Hashable, CaseIterable {
    case jarName = "Jar name"
    case changeGoalAmount = "Goal amount"
    case credits = "Credits"
    
    static let general = [jarName, changeGoalAmount]
    
    var icon: String {
        switch self {
        case .jarName: return "character.cursor.ibeam"
        case .changeGoalAmount: return "banknote"
        case .credits: return "person.2"
        }
    }
}

//enum JarSettingsRoute: Hashable {
//    case jarName(SettingsItem)
//    case goalAmount(SettingsItem)
//    case baseCurrency(SettingsItem)
//}
//
//struct SettingsItem: Hashable {
//    var title: String
//    var icon: String
//}


