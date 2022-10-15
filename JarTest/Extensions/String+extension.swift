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
//                        .font = Font.system(size: fontSize, weight: .semibold, design: .monospaced)
                        .font = Font.custom("RobotoMono-Medium", size: fontSize)
                    attributedString[attributedString.index(afterCharacter: range.lowerBound)..<attributedString.endIndex]
//                        .font = Font.system(size: decimalSize, weight: .semibold, design: .monospaced)
                        .font = Font.custom("RobotoMono-Medium", size: decimalSize)
                }
                return attributedString
    }
}
