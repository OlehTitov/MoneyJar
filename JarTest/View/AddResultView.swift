//
//  AddResultView.swift
//  JarTest
//
//  Created by Oleh Titov on 26.06.2022.
//

import SwiftUI

struct AddResultView: View {
    @EnvironmentObject private var stateController: StateController
    @Environment(\.dismiss) private var dismiss // for dismissing this view
    @Binding var mainStack: [NavigationType]
    var amount : String // to show what amount is added to account
    var titleText = "All done, congrats!"
    var descriptionText = " was sucessfully added to your account"
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                Spacer()
                Circle()
                    .frame(width: 80, height: 80)
                    .foregroundColor(Color.white)
                    .overlay {
                        Text("🥳")
                            .font(.largeTitle)
                    }
                    .padding()
                VStack(spacing: 12) {
                    Text(titleText)
                        .font(.title.bold())
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
//                MainThemeButton(action: dismissView, text: "Done")
        }
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
