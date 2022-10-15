//
//  CustomSegmentedPicker.swift
//  JarTest
//
//  Created by Oleh Titov on 07.09.2022.
//

import SwiftUI

//struct CustomSegmentedPicker: View {
//    
//    @Binding var selection: Gold.MeasurementUnit
//    var body: some View {
//        HStack {
//            ForEach(Gold.MeasurementUnit.allCases, id: \.self) { value in
//                Text(value.rawValue)
//                    .font(.headline)
//                    .foregroundColor(selection == value ? .white : .white.opacity(0.5))
//                    .padding(.horizontal, 12)
//                    .padding(.vertical, 4)
//                    .tag(value)
//                if value == 0 {
//                    Divider()
//                        .background(Color.white)
//                        .frame(height: 20)
//                }
//            }
//        }
//        .padding(8)
//        .background(Color.black.opacity(0.1))
//        .clipShape(Capsule())
//    }
//}
//
//struct CustomSegmentedPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        ZStack {
//            BlueGradientView()
//            CustomSegmentedPicker(selection: .constant(Gold.MeasurementUnit.grams))
//        }
//    }
//}
