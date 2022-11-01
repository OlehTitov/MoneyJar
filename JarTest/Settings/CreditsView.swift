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
                        .padding(.bottom)
                    //Version
                    CreditsCardView(
                        title: "Current version",
                        text: "\(Bundle.main.appVersionLong) (\(Bundle.main.appBuild))")

                    //Created by
                    CreditsCardViewWithLink(
                        url: "https://twitter.com/OlegTitov81",
                        title: "Created by",
                        text: "Oleh Titov")
                    
                    //Penguin images by
                    CreditsCardViewWithLink(
                        url: "https://www.etsy.com/shop/MIMIDigitalstudio",
                        title: "Penguin stickers by",
                        text: "MIMIDigitalstudio")
                }
                .listRowInsets(EdgeInsets.init(top: 6, leading: 16, bottom: 6, trailing: 16))
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

struct CreditsCardView: View {
    var title: String
    var text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.customBodyFont)
                .bold()
            Text(text)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(UIColor.tertiarySystemBackground))
        .cornerRadius(12)
        .font(.customBodyFont)
    }
}

struct CreditsCardViewWithLink: View {
    var url: String
    var title: String
    var text: String
    var body: some View {
        Link(destination: URL(string: url)!) {
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .bold()
                HStack {
                    Text(text)
                    Image(systemName: "arrow.up.right")
                }
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color(UIColor.tertiarySystemBackground))
            .cornerRadius(12)
            .font(.customBodyFont)
        }
    }
}
