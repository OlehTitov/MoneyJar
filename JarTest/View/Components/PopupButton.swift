//
//  PopupButton.swift
//  JarTest
//
//  Created by Oleh Titov on 01.07.2022.
//

import SwiftUI

struct PopupButton: View {
    @Binding var expand : Bool
    @Binding var selection : Int?
    @Namespace private var animation
    var body: some View {
        ZStack {
            FlyingButton(expand: $expand, iconImage: "banknote", action: {
                self.selection = 1
                self.expand = false
            }, offsetY: -100, offsetX: 0)
            FlyingButton(expand: $expand, iconImage: "crown", action: {
                self.selection = 2
                self.expand = false
            }, offsetY: -200, offsetX: 0)
            FlyingButton(expand: $expand, iconImage: "bitcoinsign.circle", action: {
                self.selection = 3
                self.expand = false
            }, offsetY: -300, offsetX: 0)
            ExplainerText(expand: expand, text: "Add cash", offsetY: -100, delay: 0.1)
            ExplainerText(expand: expand, text: "Add gold", offsetY: -200, delay: 0.2)
            ExplainerText(expand: expand, text: "Add crypto", offsetY: -300, delay: 0.3)
            
            Button {
                expand.toggle()
            }label: {
                Image(systemName: "plus")
                    .font(.largeTitle)
                    .foregroundColor(expand ? .accentColor : .white)
                    .padding()
                    .rotationEffect(Angle(degrees: expand ? 405 : 0))
                    .animation(.interactiveSpring(response: 0.2, dampingFraction: 0.5, blendDuration: 1), value: expand)
            }
            .background(expand ? .white : .accentColor)
            .clipShape(Circle())
        }
        .frame(maxWidth: .infinity, alignment: expand ? .trailing : .center)
        .frame(maxHeight: .infinity, alignment: .bottom)
        .padding(40)
        .animation(.interactiveSpring(), value: expand)
    }
}

struct PopupButton_Previews: PreviewProvider {
    static var previews: some View {
        PopupButton(expand: .constant(false), selection: .constant(1))
    }
}

struct FlyingButton: View {
    @Binding var expand : Bool
    var iconImage : String
    var action : () -> Void
    var offsetY : Double
    var offsetX: Double
    var body: some View {
        Button {
            action()
        }label: {
            Image(systemName: iconImage)
                .font(.title2)
                .foregroundColor(.white)
                .padding(20)
        }
        //.background(Color(UIColor.tertiarySystemGroupedBackground))
        .background(Color.accentColor)
        .clipShape(Circle())
        .offset(y: expand ? offsetY : 0)
        .offset(x: expand ? offsetX : 0)
        .scaleEffect(expand ? 1 : 0.3)
        .rotation3DEffect(Angle(degrees: expand ? 0 : 30), axis: (x: 1, y: 1, z: 1), anchor: .leading, anchorZ: 0, perspective: 1)
        .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.6, blendDuration: 1), value: expand)
    }
}

struct ExplainerText: View {
    var expand : Bool
    var text : String
    var offsetY : Double
    var delay : Double
    var body: some View {
        Text(text)
            .foregroundColor(.secondary)
            .padding(6)
            .background(Color(UIColor.tertiarySystemGroupedBackground))
            .cornerRadius(6)
            .offset(x: -120, y: offsetY)
            .opacity(expand ? 1 : 0)
            .transition(.opacity)
            .animation(.interactiveSpring().delay(delay), value: expand)
    }
}
