//
//  TimelineTest.swift
//  JarTest
//
//  Created by Oleh Titov on 18.09.2022.
//

import SwiftUI

struct TimelineTest: View {
    var body: some View {
            TimelineView(.animation) { context in
                let value = secondsValue(for: context.date)
                Circle()
                    .trim(from: 0, to: value)
                    .stroke()
                    .overlay {
                        Text("\(value)")
                    }
            }
            .padding()
        }

        private func secondsValue(for date: Date) -> Double {
            let seconds = Calendar.current.component(.second, from: date)
            return Double(seconds) / 60
        }
}

struct TimelineTest_Previews: PreviewProvider {
    static var previews: some View {
        TimelineTest()
    }
}
