//
//  TriangleShape.swift
//  JarTest
//
//  Created by Oleh Titov on 13.06.2022.
//

import SwiftUI

struct TriangleShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()
        return path
    }
    
    
}

struct TriangleShape_Previews: PreviewProvider {
    static var previews: some View {
        TriangleShape()
    }
}
