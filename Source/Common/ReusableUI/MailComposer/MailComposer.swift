//
//  MailCompose.swift
//  Melu
//
//  Created by apple on 04/07/20.
//  Copyright © 2020 Inrisoft. All rights reserved.
//

import Foundation
import UIKit
import MessageUI

internal final class MailComposer: NSObject {

    static let shared = MailComposer()
    
    func sendEmail(_ controller: UIViewController) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["hello@xetone.com"])
            mail.setMessageBody("<p>You're so awesome!</p>", isHTML: true)

            controller.present(mail, animated: true)
        } else {
            // show failure alert
            AlertManager.shared.displayValidationAlert(message: "Mail not configured in Device", controller: controller)
        }
    }
    
    
    
}

extension MailComposer: MFMailComposeViewControllerDelegate {
        
    internal func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
    
}


