//
//  TabBarView.swift
//  JarTest
//
//  Created by Oleh Titov on 18.08.2022.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject private var model: Model
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            AllAssetsView()
                .tabItem {
                    Label("Assets", systemImage: "list.dash")
                }
                
            PortfolioView()
                .tabItem {
                    Label("Structure", systemImage: "chart.pie")
                }
                
            SettingsView(selectedCurrency: model.account.baseCurrency)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
            .preferredColorScheme(.dark)
            .environmentObject(Model.dummyData())
    }
}
