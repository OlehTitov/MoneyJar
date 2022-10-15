//
//  AwardsView.swift
//  JarTest
//
//  Created by Oleh Titov on 03.10.2022.
//

import SwiftUI

struct AwardsView: View {
    @EnvironmentObject private var stateController: StateController
    var gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var showAward = false
    var body: some View {
        ZStack {
            BackgroundView()
            ScrollView {
                Text("You unlocked \(numberOfUnlockedAwards()) of \(stateController.account.awards.count) awards")
                    .padding()
                LazyVGrid(columns: gridItemLayout) {
                    ForEach(stateController.account.awards) { award in
                        NavigationLink{
                            AwardDetails(award: award)
                        }label: {
                            AwardThumbnailView(award: award)
                        }
                    }
                }
                .padding()
            }
        }
    }
    
    func numberOfUnlockedAwards() -> Int {
        stateController.account.awards.filter { award in
            award.status == .completed
        }.count
    }
}

struct AwardsView_Previews: PreviewProvider {
    static var previews: some View {
        AwardsView()
            .environmentObject(StateController.dummyData())
    }
}

struct AwardThumbnailView: View {
    var award: Award
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .strokeBorder(strokeColor(award: award), lineWidth: 5)
                    .frame(width: 110, height: 110)
                ConditionalAwardImage(award: award, size: 90)
            }
            VStack {
                Text(award.name)
                    .foregroundColor(.primary)
            }
        }
    }
    
    func strokeColor(award: Award) -> Color {
        award.status == .completed ? Color.green : .secondary.opacity(0.5)
    }
}

struct ConditionalAwardImage: View {
    var award: Award
    var size: Double
    var body: some View {
        VStack {
            if award.status == .completed {
                Image(award.image)
                    .resizable()
                    .frame(width: size, height: size)
                    .background(Color.white)
                    .clipShape(Circle())
            } else {
                Image(systemName: "questionmark")
                    .foregroundColor(.white)
                    .font(.title.weight(.medium))
                    .frame(width: size, height: size)
                    .background(Color.secondary)
                    .clipShape(Circle())
            }
        }
    }
}
