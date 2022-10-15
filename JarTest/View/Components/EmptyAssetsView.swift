//
//  EmptyAssetsView.swift
//  JarTest
//
//  Created by Oleh Titov on 20.08.2022.
//

import SwiftUI

struct EmptyAssetsView: View {
    var body: some View {
        VStack {
//            Spacer()
            VStack(spacing: 36) {
                Image("astronaut")
                    .resizable()
                    .frame(width: 140, height: 140, alignment: .center)
                    .padding(20)
                    .background(.ultraThinMaterial)
                    .clipShape(Circle())
                    .opacity(0.2)
                VStack(spacing: 12) {
                    Text("Your jar is empty")
                        .font(.title.bold())
                        .foregroundColor(.white.opacity(0.8))
                        .multilineTextAlignment(.center)
                    Text("Add some assets and you'll see your transactions here")
                        .foregroundColor(.white.opacity(0.6))
                        .multilineTextAlignment(.center)
                }
            }
            .padding(.top, 40)
            .padding()
            Spacer()
        }
    }
}

struct EmptyAssetsView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyAssetsView()
            .frame(maxWidth: .infinity)
            .background(Color.mirage)
    }
}
