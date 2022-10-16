//
//  AddResultView.swift
//  JarTest
//
//  Created by Oleh Titov on 26.06.2022.
//

import SwiftUI
import Subsonic

struct AddResultView: View {
    @EnvironmentObject private var stateController: StateController
    @Environment(\.dismiss) private var dismiss // for dismissing this view
    @Binding var mainStack: [NavigationType]
    var amount : String // to show what amount is added to account
    private let titleText = "All done, congrats!"
    private let descriptionText = " was sucessfully added to your account"
    private let successImage = "penguin_success"
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Image(successImage)
                    .resizable()
                    .frame(width: 100, height: 100)
                    .background(Color.white)
                    .clipShape(Circle())
                    .padding()
                VStack(spacing: 12) {
                    Text(titleText)
                        .subtitleStyle()
                    Text(amount).font(.subheadline.bold()) +
                    Text(descriptionText).font(.subheadline)
                }
                .padding()
                .multilineTextAlignment(.center)
                Spacer()
            }
            .safeAreaInset(edge: .bottom) {
                Button(action: dismissView, label: {})
                    .buttonStyle(MyButtonStyle(title: "Done"))
            }
        }
        .onAppear {
            play(sound: "coins-sound.wav")
        }
    }
    
    func dismissView() {
        mainStack = []
        dismiss()
        stateController.calculateBalance()
    }
}

struct AddResultView_Previews: PreviewProvider {
    static var previews: some View {
        AddResultView(mainStack: .constant([]), amount: "20.00 EUR")
    }
}
