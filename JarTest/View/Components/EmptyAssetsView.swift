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
            VStack(spacing: 36) {
                Image("penguin_emptyState")
                    .resizable()
                    .frame(width: 100, height: 100, alignment: .center)
                    .padding()
                    .background(Color.white)
                    .clipShape(Circle())
                VStack(spacing: 12) {
                    Text("Your jar is empty")
                        .font(.title.bold())
                        .multilineTextAlignment(.center)
                    Text("Add some assets and you'll see your transactions here")
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
            .background(Color(UIColor.secondarySystemBackground))
    }
}
