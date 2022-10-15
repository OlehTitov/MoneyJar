//
//  AwardDetails.swift
//  JarTest
//
//  Created by Oleh Titov on 03.10.2022.
//

import SwiftUI

struct AwardDetails: View {
    var award: Award
    var body: some View {
        ZStack {
            BackgroundView()
            VStack {
                ConditionalAwardImage(award: award, size: 180)
                Text(award.name)
                    .font(Font.custom("RobotoMono-Medium", size: 52))
                Text(award.detailedText)
            }
        }
    }
}

struct AwardDetails_Previews: PreviewProvider {
    static var previews: some View {
        AwardDetails(award: Award(id: 0, name: "Hello", image: "penguin_hello", status: .completed, presented: false, detailedText: "You created the jar"))
    }
}
