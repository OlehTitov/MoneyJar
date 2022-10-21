//
//  SettingsView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.08.2022.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject private var stateController: StateController
    @State var navPath: NavigationPath = NavigationPath()
    @EnvironmentObject private var settingsStore: SettingsStore
    @State var selectedCurrency: ForeignCurrency
    @AppStorage(storageKeys.soundIsOn.rawValue) var soundIsOn = true
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
                BackgroundView()
                Form {
                    ///Jar Settings
                    Section(header: Text("Jar settings").font(Font.custom("RobotoMono-Medium", size: 16))) {
                        //Jar name and Goal amount
                        ForEach(SettingsRoute.allCases, id: \.self) { route in
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
    
    var icon: String {
        switch self {
        case .jarName: return "character.cursor.ibeam"
        case .changeGoalAmount: return "banknote"
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


