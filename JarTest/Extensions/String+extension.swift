//
//  String+extension.swift
//  JarTest
//
//  Created by Oleh Titov on 05.09.2022.
//

import Foundation
import SwiftUI

extension String {
    func decimalFormat(fontSize: CGFloat, decimalSize: CGFloat) -> AttributedString {
        var attributedString = AttributedString(self)
//        let locale = NSLocale.system
        let locale = Locale.current
        guard let separator = locale.decimalSeparator else {
            return attributedString
        }
                if let range = attributedString.range(of: separator) {
                    attributedString[attributedString.startIndex...attributedString.index(beforeCharacter: range.lowerBound)]
                        .font = Font.custom("Montserrat-Bold", size: fontSize)
//                        .font = Font.system(size: fontSize, weight: .bold, design: .default)
                        .monospacedDigit()
                        
                    attributedString[attributedString.index(afterCharacter: range.lowerBound)..<attributedString.endIndex]
//                        .font = Font.system(size: decimalSize, weight: .bold, design: .default)
                        .font = Font.custom("Montserrat-Bold", size: decimalSize)
                        .monospacedDigit()
                }
                return attributedString
    }
}
