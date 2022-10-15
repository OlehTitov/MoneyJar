//
//  ChevronStyleTextButton.swift
//  JarTest
//
//  Created by Oleh Titov on 31.07.2022.
//

import SwiftUI

struct ChevronStyleTextButton: View {
    var buttonText : String
//    var action : () -> Void
    @Binding var isShowing : Bool
    var body: some View {
        Button {
            isShowing.toggle()
        }label: {
            HStack {
                Text(buttonText)
                Image(systemName: isShowing ? "chevron.up" : "chevron.down")
            }
            .foregroundColor(.white)
        }
        .buttonStyle(.plain)
        .frame(height: 20)
        .padding(.horizontal)
        .padding(.vertical, 8)
        .background(Color.black.opacity(0.1))
        .clipShape(Capsule())
    }
}

struct ChevronStyleTextButton_Previews: PreviewProvider {
    static var previews: some View {
        ChevronStyleTextButton(buttonText: "in my currency", isShowing: .constant(true))
    }
}
