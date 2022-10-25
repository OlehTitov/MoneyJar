//
//  RollingCounterAnimation.swift
//  JarTest
//
//  Created by Oleh Titov on 07.10.2022.
//

import SwiftUI
///This implementation is inspired by https://unwrappedbytes.com/2020/10/18/learn-how-to-create-a-swiftui-rolling-number-animation-that-will-amaze-your-users/

struct RollingCounterAnimation: View {
    @EnvironmentObject private var settingsStore : SettingsStore
    @State var totalAmount: Double = 0.0
    var initialBalance : Double
    var currentBalance: Double
    var fontSize: CGFloat
    var decimaSize: CGFloat
    var amountAdded: Double { currentBalance - initialBalance }
    var currencyCode : String
    var currencyLocale: String
    // Subsonic was not able to stop sound when counter stops, so AudioPlayer is used here
    @ObservedObject var player = AudioPlayer(
        name: "coins-falling",
        withExtension: "wav"
    )
    @State var stepCounter = 0
    var body: some View {
        VStack {
            Text(totalAmount.currencyFormatter(with: currencyLocale, code: currencyCode).decimalFormat(fontSize: fontSize, decimalSize: decimaSize))
//                .frame(maxWidth: .infinity, alignment: .center)
                
                .onAppear {
                    if amountAdded == 0 {
                        totalAmount = currentBalance
                    } else {
                        totalAmount = initialBalance
                        addNumberWithRollingAnimation()
                    }
                }
        }
    }
    
    /// Creates a rolling animation while adding entered number
    func addNumberWithRollingAnimation() {
        withAnimation {
            //start playing sound of coins
            if settingsStore.soundIsOn {
                player.play()
            }
            // Decide on the number of animation steps
            let animationDuration = 1600 // milliseconds
            let steps: Int = Int(min(self.amountAdded, 200))
            let stepDuration = (animationDuration / (steps == 0 ? 1 : steps))
            
            // For each step
            (0..<steps).forEach { step in
                // create the period of time when we want to update the number
                let updateTimeInterval = DispatchTimeInterval.milliseconds(step * stepDuration)
                let deadline = DispatchTime.now() + updateTimeInterval

                // tell dispatch queue to run task after the deadline
                DispatchQueue.main.asyncAfter(deadline: deadline) {
                    // Add piece of the entire entered number to our total
                    stepCounter += 1
                    self.totalAmount += self.amountAdded / Double(steps)
                    //stop playing sound of coins
                    if stepCounter == steps && settingsStore.soundIsOn {
                        player.pauseSmoothly(duration: 0)
                    }
                }
            }
        }
    }
}


struct RollingCounterAnimation_Previews: PreviewProvider {
    static var previews: some View {
        RollingCounterAnimation(initialBalance: 800.21, currentBalance: 1000.35, fontSize: 56, decimaSize: 32, currencyCode: "UAH", currencyLocale: "uk")
    }
}
