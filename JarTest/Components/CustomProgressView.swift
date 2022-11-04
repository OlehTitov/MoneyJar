//
//  CustomProgressView.swift
//  JarTest
//
//  Created by Oleh Titov on 26.10.2022.
//

import SwiftUI

struct CustomProgressView: View {
    @State var value : CGFloat = 0
    var progress: CGFloat
    var body: some View {
        
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Capsule()
                    .fill(Color(UIColor.systemFill))
                    .frame(height: 8)
                    .frame(width: geometry.size.width)
                
                Capsule()
                    .fill(Color.accentColor)
                    .frame(height: 8)
                    .frame(width: min(CGFloat(self.value)*geometry.size.width, geometry.size.width))
                
            }
        }
        .frame(height: 8)
        .onAppear {
            withAnimation(Animation.easeInOut(duration: 2).delay(1)) {
                value = progress
            }
        }
    }
}

struct CustomProgressView_Previews: PreviewProvider {
    static var previews: some View {
        CustomProgressView(value: 0.5, progress: 0.8)
    }
}
