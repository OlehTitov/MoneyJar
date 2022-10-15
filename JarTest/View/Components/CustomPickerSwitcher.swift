//
//  CustomPickerSwitcher.swift
//  JarTest
//
//  Created by Oleh Titov on 07.09.2022.
//

import SwiftUI

struct CustomPickerSwitcher<T: RawRepresentable & CaseIterable & Hashable> : View where T.AllCases: RandomAccessCollection, T.RawValue == String  {
    let someEnum: T.Type
    @Binding var selection: T


    var body: some View {
        HStack {
            ForEach(someEnum.allCases, id: \.self) {item in
                Text(item.rawValue)
                    .foregroundColor(selection == item ? .white : .primary)
                    .onTapGesture {
                        selection = item
                    }
            }
        }
    }
}

//struct CustomPickerSwitcher_Previews: PreviewProvider {
//    static var previews: some View {
//        CustomPickerSwitcher<SelectionValue: Hashable>()
//    }
//}
