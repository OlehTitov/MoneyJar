//
//  AwardUnlockedSheet.swift
//  JarTest
//
//  Created by Oleh Titov on 05.10.2022.
//

import SwiftUI
import Subsonic

struct AwardUnlockedSheet: View {
    @EnvironmentObject private var stateController: StateController
    @Binding var show: Bool
    var award: Award
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                VStack{
                    Text("Award unlocked!")
                        .font(Font.custom("RobotoMono-Medium", size: 20))
                    Spacer()
                    VStack(spacing: 18){
                        Image(award.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                        Text(award.name)
                            .font(.title2.bold())
                        Text(award.detailedText)
                    }
                    Spacer()
                    Button(action: {
                        self.show = false
                        DispatchQueue.main.async {
                            stateController.markAwardAsPresented(award: award)
                        }
                        
                        print(stateController.account.awards)
                    }, label: {})
                    .buttonStyle(MyButtonStyle(title: "OK"))
                }
                .padding()
            }
            .onAppear {
                play(sound: "upward_confirmation.wav")
            }
        }
    }
}

struct AwardUnlockedSheet_Previews: PreviewProvider {
    static var previews: some View {
        AwardUnlockedSheet(show: .constant(true), award: Award(id: 0, name: "test name", image: "1_engage", status: .completed, presented: false, detailedText: "test detail text"))
    }
}
