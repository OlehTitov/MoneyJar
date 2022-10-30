//
//  AwardUnlockedSheet.swift
//  JarTest
//
//  Created by Oleh Titov on 05.10.2022.
//

import SwiftUI
import Subsonic

struct AwardUnlockedSheet: View {
    @EnvironmentObject private var model: Model
    @EnvironmentObject private var settingsStore : SettingsStore
    @Binding var show: Bool
    var award: Award
    var body: some View {
        ZStack {
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack {
                VStack{
                    Text("Award unlocked!")
                        .font(.customTitleFont)
                    Spacer()
                    VStack(spacing: 18){
                        Image(award.image)
                            .resizable()
                            .frame(width: 100, height: 100)
                            .padding()
                            .background(Color.white)
                            .clipShape(Circle())
                        Text(award.name)
                            .font(.customHeadlineFont)
                        Text(award.detailedText)
                            .font(.customBodyFont)
                    }
                    Spacer()
                    Button("OK") {
                        self.show = false
                        DispatchQueue.main.async {
                            model.markAwardAsPresented(award: award)
                        }
                        print(model.account.awards)
                    }
                    .buttonStyle(PrimaryButtonStyle())
                }
                .padding()
            }
            .onAppear {
                if settingsStore.soundIsOn {
                    play(sound: "upward_confirmation.wav")
                }
            }
        }
    }
}

struct AwardUnlockedSheet_Previews: PreviewProvider {
    static var previews: some View {
        AwardUnlockedSheet(show: .constant(true), award: Award(id: 0, name: "test name", image: "1_engage", status: .completed, presented: false, detailedText: "test detail text"))
            .environmentObject(SettingsStore())
    }
}
