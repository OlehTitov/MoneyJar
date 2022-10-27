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
            Color(UIColor.secondarySystemBackground)
                .ignoresSafeArea()
            VStack(spacing: 18) {
                ConditionalAwardImage(award: award, size: 180)
                Text(award.name)
                    .font(.customTitleFont)
                Text(award.detailedText)
                    .font(.customBodyFont)
            }
        }
    }
}

struct AwardDetails_Previews: PreviewProvider {
    static var previews: some View {
        AwardDetails(award: Award(id: 0, name: "Hello", image: "penguin_hello", status: .completed, presented: false, detailedText: "You created the jar"))
    }
}
