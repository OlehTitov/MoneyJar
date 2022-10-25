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
                        .frame(width: 140, height: 140)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                    //Version
                    Label {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Current version")
                                .foregroundColor(.secondary)
                            Text("\(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")
                                .fontWeight(.bold)
                        }
                    } icon: {
                        Image(systemName: "info")
                            .font(.title2.weight(.regular))
                            .frame(width: 50, height: 50)
                            .background(Color.black.opacity(0.1))
                            .cornerRadius(12)
                    }
                    .labelStyle(CenteredLabelStyle())
                    //Created by
                    Label {
                        VStack(alignment: .leading, spacing: 6) {
                            Text("Created by")
                                .foregroundColor(.secondary)
                            Link(destination: URL(string: StateController.appStoreReviewLink)!) {
                                HStack {
                                    Text("Oleh Titov")
                                    Image(systemName: "arrow.up.right")
                                }
                            }
                        }
                    } icon: {
                        Image(systemName: "face.smiling")
                            .font(.title2.weight(.light))
                            .frame(width: 30, height: 30)
//                            .background(Color.black.opacity(0.1))
//                            .cornerRadius(12)
                    }
                    .labelStyle(CenteredLabelStyle())
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
