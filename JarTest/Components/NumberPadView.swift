//
//  NumberPadView.swift
//  JarTest
//
//  Created by Oleh Titov on 28.06.2022.
//

import SwiftUI

struct NumberPadView: View {
    @Binding var text : String
    @Binding var showPlaceholder : Bool
    @Binding var amountAsDouble : Double
    @Binding var presentAlert : Bool
    @Binding var alertDescription : String
    var showDecimal : Bool
    var currency : ForeignCurrency
    var isForCrypto : Bool
    var gridItemLayout = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    @State var amt : Int = 0
    
    var body: some View {
        LazyVGrid(columns: gridItemLayout, spacing: 8) {
            ForEach((Digit.allCases), id: \.self) { digit in
                Button {
                    numberPressed(number: digit)
                }label: {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(height: 50)
                        .frame(maxWidth: .infinity)
                        .foregroundColor(
                            Color(UIColor.tertiarySystemBackground).opacity(backgroundColoringLogic(key: digit))
                        )
                        .overlay {
                            if digit == .delete {
                                Image(systemName: digit.rawValue)
                                    .font(Font.system(size: 26, weight: .regular, design: .default))
                                    .offset(x: -3)
                            } else if digit == .period {
                                Text(digit.rawValue)
                                    .font(Font.system(size: 26, weight: .bold, design: .default))
                                    .opacity(showDecimal ? 1 : 0)
                            } else {
                                Text(digit.rawValue)
                                    .font(Font.system(size: 26, weight: .regular, design: .default))
                            }
                        }
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
    }
    enum Digit : String, CaseIterable {
        case one = "1"
        case two = "2"
        case three = "3"
        case four = "4"
        case five = "5"
        case six = "6"
        case seven = "7"
        case eight = "8"
        case nine = "9"
        case period = "."
        case zero = "0"
        case delete = "delete.backward"
    }
    
    func numberPressed(number: Digit) {
        simpleSuccess()
        showPlaceholder = false
        if isForCrypto {
            //Handle crypto input
            simpleSuccess()
            if number == .delete && text.isEmpty {
                showPlaceholder = true
            } else if number == .delete && !text.isEmpty {
                self.text.removeLast()
                if self.text == "" {
                    showPlaceholder = true
                }
            } else {
                self.text.append(contentsOf: number.rawValue)
                let dots = text.components(separatedBy: ".")
                if dots.count >= 3 {
                    //present alert
                    self.presentAlert = true
//                    self.text = ""
                    self.alertDescription = "Remove extra dots"
                }
                if Int(text) ?? 0 > 21_000_000 {
                    //present alert
                    self.presentAlert = true
                    self.text = ""
                    self.alertDescription = "Please enter amount less than 21 mln"
                }
            }
        } else {
            //Handle currency input
            if number == .delete && !text.isEmpty {
                var oldAmtAsString = String(amt)
                oldAmtAsString.removeLast()
                amt = Int(oldAmtAsString) ?? 0
                self.text = updateAmount()
            } else {
                if let digit = Int(number.rawValue) {
                    amt = amt * 10 + digit
                    print("amt : \(amt)")
                    print("digit : \(digit)")
                    if amt > 999_999_999_99 {
                        //present alert
                        self.presentAlert = true
                        self.text = ""
                        self.alertDescription = "Please enter amount less than 1 billion"
                        amt = 0
                    } else {
                        self.text = updateAmount()
                    }
                }
            }
            
            if self.text == "" {
                amt = 0
                showPlaceholder = true
            }
            
        }
        
    }
    
    func updateAmount() -> String {
        let amount = Double(amt/100) + Double(amt%100)/100
        amountAsDouble = amount
        return currency.formatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    ///Method that can be called where the View is declared. Just testing how it works. These kind of methods shoul return Self
//    func placeCurrentGoalAmount() -> Self {
//        var view = self
//        DispatchQueue.main.async {
//            view.showPlaceholder = false
//            view.amountAsDouble = 1000.00
//            let formatter = currency.formatter
//            view.text = formatter.string(from: NSNumber(value: 1000)) ?? ""
//        }
//        return view
//    }
    
    func simpleSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    func backgroundColoringLogic(key: Digit) -> Double {
        let normalState = 1.0
        switch key {
        case .one:
            return normalState
        case .two:
            return normalState
        case .three:
            return normalState
        case .four:
            return normalState
        case .five:
            return normalState
        case .six:
            return normalState
        case .seven:
            return normalState
        case .eight:
            return normalState
        case .nine:
            return normalState
        case .period:
            let result = showDecimal ? normalState : 0
            return  result
        case .zero:
            return normalState
        case .delete:
            return 0
        }
    }
    
}

struct NumberPadView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            NumberPadView(text: .constant(""), showPlaceholder: .constant(true), amountAsDouble: .constant(0.0), presentAlert: .constant(false), alertDescription: .constant("test alert text"), showDecimal: true, currency: .usd, isForCrypto: true)
        }
        .frame(maxHeight: .infinity)
        .background(Color.mirage)
    }
}
