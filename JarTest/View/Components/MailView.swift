//
//  MailView.swift
//  JarTest
//
//  Created by Oleh Titov on 23.10.2022.
//

///https://stackoverflow.com/questions/56784722/swiftui-send-email

import AVFoundation
import Foundation
import MessageUI
import SwiftUI
import UIKit

struct MailView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentation
    @Binding var result: Result<MFMailComposeResult, Error>?
    var recipients: [String]
    var subject: String
    var messageBody = ""

    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        @Binding var presentation: PresentationMode
        @Binding var result: Result<MFMailComposeResult, Error>?
        var recipients: [String]
        var subject: String

        init(presentation: Binding<PresentationMode>,
             result: Binding<Result<MFMailComposeResult, Error>?>,
             recipients: [String],
             subject: String
        )
        {
            _presentation = presentation
            _result = result
            self.recipients = recipients
            self.subject = subject
        }

        func mailComposeController(_: MFMailComposeViewController,
                                   didFinishWith result: MFMailComposeResult,
                                   error: Error?)
        {
            defer {
                $presentation.wrappedValue.dismiss()
            }
            guard error == nil else {
                self.result = .failure(error!)
                return
            }
            self.result = .success(result)
            
            if result == .sent {
            AudioServicesPlayAlertSound(SystemSoundID(1001))
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentation: presentation,
                           result: $result,
                           recipients: recipients,
                           subject: subject)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<MailView>) -> MFMailComposeViewController {
        let vc = MFMailComposeViewController()
        vc.setToRecipients(recipients)
        vc.setMessageBody(messageBody, isHTML: true)
        vc.setSubject(subject)
        vc.mailComposeDelegate = context.coordinator
        return vc
    }

    func updateUIViewController(_: MFMailComposeViewController,
                                context _: UIViewControllerRepresentableContext<MailView>) {}
}
