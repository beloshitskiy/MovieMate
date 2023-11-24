//
//  AlertController.swift
//  MovieMate
//
//  Created by denis.beloshitsky on 12.11.2023.
//

import UIKit

final class AlertController {
    static func showAlert(vc: UIViewController,
                          title: String,
                          message: String,
                          buttonTitle: String,
                          action: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default, handler: { _ in action?() }))
        vc.present(alert, animated: true)
    }

    static func showAlert(vc: UIViewController, errorInfo: ErrorInfo) {
        self.showAlert(vc: vc,
                       title: errorInfo.title,
                       message: errorInfo.message,
                       buttonTitle: errorInfo.buttonTitle,
                       action: errorInfo.action)
    }
}
