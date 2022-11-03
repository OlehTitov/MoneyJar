//
//  Date+extension.swift
//  JarTest
//
//  Created by Oleh Titov on 19.08.2022.
//

import Foundation

extension Date {

    var onlyDate: Date? {
        get {
            let calender = Calendar.current
            var dateComponents = calender.dateComponents([.year, .month, .day], from: self)
            dateComponents.timeZone = NSTimeZone.system
            return calender.date(from: dateComponents)
        }
    }

}


extension Date {
    
    var toString: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeZone = .current
        print(formatter.string(from: self))
        return formatter.string(from: self)
    }
    
}

