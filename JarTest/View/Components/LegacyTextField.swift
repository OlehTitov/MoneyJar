//
//  LegacyTextField.swift
//  JarTest
//
//  Created by Oleh Titov on 19.06.2022.
//

import Foundation
import SwiftUI

struct LegacyTextField: UIViewRepresentable {
    @Binding public var isFirstResponder: Bool
    @Binding public var text: String
    //public var currency : String
    public var keyboard : UIKeyboardType
    
    public var configuration = { (view: UITextField) in }
    
    public init(text: Binding<String>, isFirstResponder: Binding<Bool>, keyboard: UIKeyboardType, configuration: @escaping (UITextField) -> () = { _ in }) {
        self.configuration = configuration
        self._text = text
        self._isFirstResponder = isFirstResponder
//        self.currency = currency
        self.keyboard = keyboard
    }
    
    public func makeUIView(context: Context) -> UITextField {
        let view = UITextField()
        view.keyboardType = keyboard
//        view.font = .boldSystemFont(ofSize: 26)
        view.font = .customTitleFont()
//        view.textColor = .white
        view.autocorrectionType = .no
        view.contentHorizontalAlignment = .center
        view.textAlignment = .center
        view.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        view.addTarget(context.coordinator, action: #selector(Coordinator.textViewDidChange), for: .editingChanged)
        view.delegate = context.coordinator
        return view
    }
    
    public func updateUIView(_ uiView: UITextField, context: Context) {
        uiView.text = text
        configuration(uiView)
        switch isFirstResponder {
        case true: uiView.becomeFirstResponder()
        case false: uiView.resignFirstResponder()
        }
    }
    
    public func makeCoordinator() -> Coordinator {
        Coordinator($text, isFirstResponder: $isFirstResponder, keyboard: keyboard)
    }
    
    public class Coordinator: NSObject, UITextFieldDelegate {
        var text: Binding<String>
        var isFirstResponder: Binding<Bool>
        var keyboard: UIKeyboardType
//        var currency: String
        
        init(_ text: Binding<String>, isFirstResponder: Binding<Bool>, keyboard: UIKeyboardType) {
            self.text = text
            self.isFirstResponder = isFirstResponder
            self.keyboard = keyboard
//            self.currency = currency
        }
        
        @objc public func textViewDidChange(_ textField: UITextField) {
            self.text.wrappedValue = textField.text ?? ""
        }
        
//        public func textFieldDidBeginEditing(_ textField: UITextField) {
//            self.isFirstResponder.wrappedValue = true
//        }
        
        public func textFieldDidEndEditing(_ textField: UITextField) {
            self.isFirstResponder.wrappedValue = false
        }
        
        public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
            if keyboard == .decimalPad {
                /**
                 Default value 0 is replaced with user input
                 https://stackoverflow.com/questions/51926523/setting-default-uitextfield-value-of-0-calculator
                 */
                guard let textFieldString = textField.text, let range = Range(range, in: textFieldString) else {
                    return false
                }
                let newString = textFieldString.replacingCharacters(in: range, with: string)
                if newString.isEmpty {
                    textField.text = "0"
                    return false
                } else if textField.text == "0" {
                    textField.text = string
                    return false
                }
                return true
            } else {
                // get the current text, or use an empty string if that failed
                let currentText = textField.text ?? ""
                // attempt to read the range they are trying to change, or exit if we can't
                guard let stringRange = Range(range, in: currentText) else { return false }
                // add their new text to the existing text
                let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
                // make sure the result is under 24 characters
                return updatedText.count <= 24
            }
        }
    }
}
