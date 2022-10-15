//
//  ForeignCurrencyTextField.swift
//  JarTest
//
//  Created by Oleh Titov on 25.06.2022.
//

import Foundation
import SwiftUI

struct ForeignCurrencyTextField: UIViewRepresentable {
    /**
     Fuck... I've spent two days to make it work...
     The key was to make a Parent property in Coordinator, so that it can access CHANGING currency property in ForeignCurrencyTextField. Otherwise Coordinator had a permanent value that was set during the init()
     */
    @Binding public var isFirstResponder: Bool
    @Binding public var text: String
    @Binding public var presentAlert : Bool
    @Binding public var amountAsDouble : Double
    @Binding public var amt: Int
    @Binding public var currency : ForeignCurrency
    
    public var configuration = { (view: UITextField) in }
    
    public init(text: Binding<String>, isFirstResponder: Binding<Bool>, presentAlert: Binding<Bool>, amountAsDouble: Binding<Double>, currency: Binding<ForeignCurrency>, amount: Binding<Int>, configuration: @escaping (UITextField) -> () = { _ in }) {
        self.configuration = configuration
        self._text = text
        self._isFirstResponder = isFirstResponder
        self._presentAlert = presentAlert
        self._amountAsDouble = amountAsDouble
        self._currency = currency
        self._amt = amount
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.keyboardType = .decimalPad
        view.placeholder = updateAmount1()
        view.tintColor = UIColor.clear
        view.font = .boldSystemFont(ofSize: 48)
        view.autocorrectionType = .no
        view.contentHorizontalAlignment = .center
        view.textAlignment = .center
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = updateAmount1()
        configuration(uiView)
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
    }
    
    func updateAmount1() -> String? {
        let formatter = currency.formatter
        let amount = Double(amt/100) + Double(amt%100)/100
        return formatter.string(from: NSNumber(value: amount))
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator(self, amount: amt, amountAsDouble: $amountAsDouble)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        let parent : ForeignCurrencyTextField
        var amt : Int
        var amountAsDouble: Binding<Double>
        init(_ foreignCurrencyTextField: ForeignCurrencyTextField, amount: Int, amountAsDouble: Binding<Double>) {
            self.parent = foreignCurrencyTextField
            self.amt = amount
            self.amountAsDouble = amountAsDouble
        }
        
        
        @objc public func textViewDidChange(_ textField: UITextField) {
            parent.$text.wrappedValue = updateAmount() ?? ""
        }
        
        public func textFieldDidBeginEditing(_ textField: UITextField) {
            parent.$isFirstResponder.wrappedValue = true
        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            DispatchQueue.main.async {
                self.parent.$isFirstResponder.wrappedValue = false
                //Trying to reset value to 0 when user finished editing and added the assest to account
                self.parent.amt = 0
                self.amt = 0
                self.parent.$text.wrappedValue = ""
                //self.parent.updateAmount1()
            }
            
//            parent.$text.wrappedValue = ""
//            self.amountAsDouble.wrappedValue = 0.0
        }
        
        public func updateAmount() -> String? {
            let amount = Double(amt/100) + Double(amt%100)/100
            self.amountAsDouble.wrappedValue = amount
            return parent.currency.formatter.string(from: NSNumber(value: amount))
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if let digit = Int(string) {
                amt = amt * 10 + digit
                print("amt : \(amt)")
                print("digit : \(digit)")
                if amt > 1_000_000_000_00 {
                    parent.$presentAlert.wrappedValue = true
                    textField.text = ""
                    amt = 0
                } else {
                    textField.text = updateAmount()
                }
            }
            
            if string == "" {
                amt = amt/10
                textField.text = amt == 0 ? "" : updateAmount()
            }
            
            return false
        }
    }
    
    
}
