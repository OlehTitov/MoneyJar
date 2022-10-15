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
//    @StateObject var settingsStore: SettingsStore
    var body: some View {
        NavigationStack(path: $navPath) {
            ZStack {
//                BlueGradientView()
                List {
                    Section(header: Text("Jar settings").font(Font.custom("RobotoMono-Medium", size: 18))) {
                        ForEach(SettingsRoute.allCases, id: \.self) { route in
                            NavigationLink(value: route) {
                                HStack {
                                    Image(systemName: route.icon)
                                        .foregroundColor(Color.accentColor)
                                        .frame(width: 40, height: 30, alignment: .center)
                                    Text(route.rawValue)
                                }
                            }
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
                    case .changeGoalAmount: Text("Some view")
                    case .changeBaseCurrency: Text("Some view")
                }
            })
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackground(colorScheme == .dark ? Color("shipCove") : Color("mint"), for: .navigationBar)
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(StateController.dummyData())
    }
}

enum SettingsRoute: String, Hashable, CaseIterable {
    case jarName = "Jar name"
    case changeGoalAmount = "Goal amount"
    case changeBaseCurrency = "Base currency"
    
    var icon: String {
        switch self {
        case .jarName: return "character.cursor.ibeam"
        case .changeGoalAmount: return "banknote"
        case .changeBaseCurrency: return "dollarsign"
        }
    }
}

enum JarSettingsRoute: Hashable {
    case jarName(SettingsItem)
    case goalAmount(SettingsItem)
    case baseCurrency(SettingsItem)
}

struct SettingsItem: Hashable {
    var title: String
    var icon: String
}


