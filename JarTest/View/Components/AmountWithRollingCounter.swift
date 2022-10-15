//
//  AmountWithRollingCounter.swift
//  JarTest
//
//  Created by Oleh Titov on 15.08.2022.
//

import SwiftUI
import Subsonic

struct AmountWithRollingCounter: View {
    var player: AudioPlayer
    @State var totalAmount: Double = 0.0
    var initialBalance : Double
    var currentBalance: Double
    var fontSize: CGFloat
    var decimaSize: CGFloat
    var amountAdded: Double {
        currentBalance - initialBalance
    }
    var currencyCode : String
    var currencyLocale: String
    //Check for grteetings so two sounds should not overlap
    var greetingSoundPlayed = UserDefaults.standard.bool(forKey: storageKeys.greetingSoundPlayed.rawValue)
    @State var number = 0 // for debugging
    @State var isPlaying: Bool = false
    var body: some View {
        TimelineView(.animation) { context in
            var nanoseconds = Calendar.current.component(.nanosecond, from: context.date)
            var customFrequency = (nanoseconds * 500_000_000)
            
            Text(totalAmount.currencyFormatter(
                with: currencyLocale,
                code: currencyCode).decimalFormat(
                    fontSize: fontSize,
                    decimalSize: decimaSize
                )
            )
            .sound("coins-falling.wav", isPlaying: $isPlaying)
            .frame(maxWidth: .infinity, alignment: .center)
            .onChange(of: customFrequency) { newValue in
                if totalAmount < currentBalance && greetingSoundPlayed {
//                    player.play()
                    isPlaying = true
                    totalAmount += amountAdded/Double(stepsNumber())
                    number += 1
                    print("Number of times: \(number)")
                    print("Custom frequency: \(customFrequency)")
                    if totalAmount == currentBalance || totalAmount > currentBalance {
                        totalAmount = currentBalance
//                        player.player.pause()
                        isPlaying = false
                        number = 0
                        print("Reset")
                        nanoseconds = 0
                        customFrequency = 0
//                        player.pauseSmoothly(duration: 1)
                    }
                }
            }
        }
    }
    
    func stepsNumber() -> Int {
        let roughtSteps = Int(amountAdded)/10
        if roughtSteps < 5 {
            return 5
        } else if roughtSteps > 50 {
            return 50
        } else {
            return roughtSteps
        }
    }
    
//    var isPlaying: Bool {
//        totalAmount < currentBalance
//    }
    
}

struct AmountWithRollingCounter_Previews: PreviewProvider {
    static var previews: some View {
        AmountWithRollingCounter(
            player: AudioPlayer(name: "coins-falling", withExtension: "wav"),
            initialBalance: 1280,
            currentBalance: 2000,
            fontSize: 56,
            decimaSize: 32,
            currencyCode: "UAH",
            currencyLocale: "uk"
        )
        .background(Color.mirage)
    }
}
