//
//  SettingsView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.08.2022.
//

import SwiftUI
import MessageUI
import StoreKit

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.requestReview) var requestReview
    @EnvironmentObject private var model: Model
    @State var navPath: NavigationPath = NavigationPath()
    @EnvironmentObject private var settingsStore: SettingsStore
    @State var selectedCurrency: ForeignCurrency
    @AppStorage(StorageKeys.soundIsOn.rawValue) var soundIsOn = true
    //Mail settings
    @State var isShowingMailView = false
    @State var alertNoMail = false
    @State var result: Result<MFMailComposeResult, Error>? = nil
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                BackgroundView()
                List {
                    ///Jar Settings
                    Section(header: Text("Jar configuration")) {
                        //Jar name and Goal amount
                        ForEach(SettingsRoute.general, id: \.self) { route in
                            NavigationLink(value: route) {
                                Label {
                                    Text(route.rawValue)
                                }icon: {
                                    Image(systemName: route.icon)
                                }
                            }
                            .modifier(SettingRowStyle())
                        }
                        //Base currency
                        Picker(
                            selection: $selectedCurrency,
                            label: Label {
                                Text("Base currency")
                            }icon: {
                                Image(systemName: "dollarsign")
                            }
                        ) {
                            ForEach(ForeignCurrency.allCases, id: \.self) { currency in
                                Text(currency.longDescription)
                                    .font(.customBodyFont)
                            }
                        }
                        .modifier(SettingRowStyle())
                    }
                    .listRowInsets(EdgeInsets.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    ///General Settings
                    Section(header: Text("General")) {
                        //Sound settings
                        Label {
                            Toggle(isOn: $settingsStore.soundIsOn) {
                                Text("Sound")
                            }
                                .tint(Color.accentColor)
                        } icon: {
                            Image(systemName: "music.note")
                        }
                        .modifier(SettingRowStyle())
                        //Haptic settings
                        ///Add haptics in later releases
//                        Label {
//                            Toggle("Haptics", isOn: $settingsStore.hapticsIsOn)
//                                .tint(Color.accentColor)
//                        } icon: {
//                            Image(systemName: "hand.tap")
//                        }
//                        .modifier(SettingRowStyle())
                    }
                    .listRowInsets(EdgeInsets.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    ///Get in touch
                    Section(header: Text("Get in touch")) {
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
                        .modifier(SettingRowStyle())
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
                        /// requestReview may not work. need App id to open URL libk to write review
//                        Button {
//                            requestReview()
//                        } label: {
//                            HStack {
//                                Label {
//                                    Text("Rate in AppStore")
//                                        .font(.customHeadlineFont)
//                                }icon: {
//                                    Image(systemName: "star")
//                                }
//                                Spacer()
//                                Image(systemName: "arrow.up.right")
//                            }
//                        }
//                        .buttonStyle(.plain)

                    }
                    .listRowInsets(EdgeInsets.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    
                    ///Other
                    Section {
                        NavigationLink(value: SettingsRoute.credits) {
                            Label {
                                Text(SettingsRoute.credits.rawValue)
//                                    .font(.customHeadlineFont)
                            }icon: {
                                Image(systemName: SettingsRoute.credits.icon)
                            }
                        }
                        .modifier(SettingRowStyle())
                    }
                    .listRowInsets(EdgeInsets.init(top: 6, leading: 16, bottom: 6, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                }
//                .environment(\.defaultMinListRowHeight, 0)
                .listStyle(.plain)
                .listRowInsets(EdgeInsets.init(top: 0, leading: 4, bottom: 0, trailing: 4))
                .scrollContentBackground(.hidden)
            }
            .navigationDestination(for: SettingsRoute.self, destination: { route in
                switch route {
                case .jarName: ChangeJarNameView(path: $navPath, jarName: model.account.name)
                case .changeGoalAmount: ChangeAmountView(path: $navPath)
                case .credits: CreditsView()
                }
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
        }
        .onChange(of: selectedCurrency) { newValue in
            model.setBaseCurrency(newValue: newValue)
            model.calculateBalance()
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(selectedCurrency: .usd)
            .environmentObject(Model.dummyData())
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


