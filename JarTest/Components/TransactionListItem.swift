//
//  TransactionListItem.swift
//  JarTest
//
//  Created by Oleh Titov on 19.08.2022.
//

import SwiftUI

struct TransactionListItem: View {
    var image: String
    var name: String
    var assetType: String
    var quantity: String
    var isCommodity: Bool
    var color: Color?
    var body: some View {
        HStack {
            if isCommodity {
                Circle()
                    .fill(commodityColor())
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(8)
                    .overlay {
                        Text("XAU")
                            .foregroundColor(.white)
                    }
            } else {
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .frame(width: 50, height: 50, alignment: .center)
                    .padding(8)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .font(.customHeadlineFont)
                Text(assetType)
//                    .opacity(0.6)
                    .font(.customBodyFont)
            }
            Spacer()
            if !quantity.isEmpty {
                Text(quantity)
                    .font(.customHeadlineFont)
            }
        }
    }
    
    func commodityColor() -> Color {
        guard let color = color else {
            return .blue
        }
        return color
    }
}

struct TransactionListItem_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
           
            List(/*@START_MENU_TOKEN@*/0 ..< 5/*@END_MENU_TOKEN@*/) { item in
                TransactionListItem(image: "USD", name: "Bitcoin", assetType: "Cryptocurrency", quantity: "0.003", isCommodity: false)
                    .listRowBackground(Color.clear)
            }
            .listStyle(.plain)
        }
    }
}
