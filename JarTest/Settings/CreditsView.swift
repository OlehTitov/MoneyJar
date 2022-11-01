//
//  CreditsView.swift
//  JarTest
//
//  Created by Oleh Titov on 24.10.2022.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        ZStack {
            BackgroundView()
            List {
                Section {
                    Image("AppColorIcon")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    //Version
                    Label {
                        HStack {
                            Text("Current version")
                            Spacer()
                            Text("\(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                                .bold()
                        }
                    } icon: {
                        Image(systemName: "info")
                    }
                    .modifier(SettingRowStyle())

                    //Created by
                    Link(destination: URL(string: "https://twitter.com/OlegTitov81")!) {
                        Label {
                            HStack {
                                Text("Created by")
                                Spacer()
                                HStack {
                                    Text("Oleh Titov")
                                        .bold()
                                    Image(systemName: "arrow.up.right")
                                }
                            }
                        } icon: {
                            Image(systemName: "face.smiling")
                        }
                        .modifier(SettingRowStyle())
                    }
                    
                    //Penguin images by
                    Link(destination: URL(string: "https://www.etsy.com/shop/MIMIDigitalstudio")!) {
                        Label {
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Penguin images by")
                                HStack {
                                    Text("MIMIDigitalstudio")
                                        .bold()
                                    Image(systemName: "arrow.up.right")
                                }
                            }
                        } icon: {
                            Image(systemName: "paintbrush.pointed")
                        }
                        .modifier(SettingRowStyle())
                    }
                    
                }
                .listRowBackground(Color.clear)
                .listRowSeparator(.hidden)
            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
        }
    }
}

struct CreditsView_Previews: PreviewProvider {
    static var previews: some View {
        CreditsView()
    }
}
