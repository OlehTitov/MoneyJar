//
//  SegmentedPickerGoldMeasurementUnits.swift
//  JarTest
//
//  Created by Oleh Titov on 08.09.2022.
//

import SwiftUI

struct SegmentedPickerGoldMeasurementUnits: View {
    @Binding var selection : Gold.MeasurementUnit
    var body: some View {
        HStack {
            Text("Grams")
                .font(.headline)
                .foregroundColor(selection == .grams ? .primary : .secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .onTapGesture {
                    withAnimation {
                        self.selection = .grams
                    }
                }
            Divider()
                .background(Color.white)
                .frame(height: 20)
            Text("Ounces")
                .font(.headline)
                .foregroundColor(selection == .ounces ? .primary : .secondary)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .onTapGesture {
                    withAnimation {
                        self.selection = .ounces
                    }
                }
        }
        .padding(8)
        .padding(.vertical, 8)
        .background(Color.black.opacity(0.1))
        .cornerRadius(8)
    }
}

struct SegmentedPickerGoldMeasurementUnits_Previews: PreviewProvider {
    static var previews: some View {
        SegmentedPickerGoldMeasurementUnits(selection: .constant(.grams))
    }
}
