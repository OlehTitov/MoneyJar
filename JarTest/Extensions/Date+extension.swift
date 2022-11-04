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
    
    func toString(format: DateFormatter.Style, showTime: Bool) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = format
        formatter.timeZone = .current
        if showTime {
            formatter.timeStyle = .short
        }
        formatter.timeZone = .current
        print(formatter.string(from: self))
        return formatter.string(from: self)
    }
    
    func timeOnlyToString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm a"
        return formatter.string(from: self)
    }
    
}

