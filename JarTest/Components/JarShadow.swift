//
//  AmbientLight.swift
//  JarTest
//
//  Created by Oleh Titov on 25.08.2022.
//

import SwiftUI

struct JarShadow: View {
    var width: Double
    var height: Double
    var blurRadius: Double
    var opacity: Double
    var body: some View {
        Ellipse()
            .fill(Color.black.opacity(0.7))
            .frame(width: width, height: height, alignment: .center)
            .blur(radius: blurRadius, opaque: false)
            .opacity(opacity)
    }
}

struct JarShadow_Previews: PreviewProvider {
    static var previews: some View {
        JarShadow(width: 280, height: 20, blurRadius: 20, opacity: 0.6)
    }
}
