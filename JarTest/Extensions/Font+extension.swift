//
//  Font+extension.swift
//  JarTest
//
//  Created by Oleh Titov on 27.10.2022.
//

import Foundation
import SwiftUI

extension Font {

    static var customCaptionFont: Font {
        Font.custom("Montserrat-Regular", size: 14, relativeTo: .caption)
    }
    
    static var customBodyFont: Font {
        Font.custom("Montserrat-Regular", size: 16, relativeTo: .body)
    }
    
    static var customHeadlineFont: Font {
        Font.custom("Montserrat-Medium", size: 18, relativeTo: .body)
    }
    
    static var customButtonTextFont: Font {
        Font.custom("Montserrat-Bold", size: 18, relativeTo: .body)
    }
    
    static var customTitleFont: Font {
        Font.custom("Montserrat-Bold", size: 28, relativeTo: .title)
    }
    
    static var customLargeTitleFont: Font {
        Font.custom("Montserrat-Bold", size: 40, relativeTo: .largeTitle)
    }
}

extension UIFont {
    private static func customFont(name: String, size: CGFloat) -> UIFont {
            let font = UIFont(name: name, size: size)
            assert(font != nil, "Can't load font: \(name)")
            return font ?? UIFont.systemFont(ofSize: size)
        }
        
    static func customHeadlineFont() -> UIFont {
        return customFont(name: "Montserrat-Medium", size: 18)
    }
    
    static func customButtonTextFont() -> UIFont {
        return customFont(name: "Montserrat-Bold", size: 18)
    }
    
    static func customTitleFont() -> UIFont {
        return customFont(name: "Montserrat-Bold", size: 28)
    }
    
    static func customLargeTitleFont() -> UIFont {
        return customFont(name: "Montserrat-Bold", size: 40)
    }
}
