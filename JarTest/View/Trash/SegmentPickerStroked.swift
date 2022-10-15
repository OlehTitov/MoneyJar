//
//  SegmentPickerStroked.swift
//  JarTest
//
//  Created by Oleh Titov on 05.07.2022.
//

import SwiftUI

struct SegmentPickerStroked: View {
    
    //Properties for picker
    @Binding private var selection : Int
    private let items : [(String, String)]
    
    init(items: [(String, String)], selection: Binding<Int>) {
            self._selection = selection
            self.items = items
        }
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct SegmentPickerStroked_Previews: PreviewProvider {
    static var previews: some View {
        SegmentPickerStroked(items: [("scalemass","gold bar"), ("pencil.and.outline", "gold coin")], selection: .constant(0))
    }
}
