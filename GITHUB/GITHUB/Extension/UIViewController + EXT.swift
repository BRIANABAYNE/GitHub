//
//  UIViewController + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/30/24.
//

import UIKit
import SafariServices


extension UIViewController {
    
    // MARK: - Method
    
    func presentGFAlert(alertTitle: String, message: String, buttonTitle: String) {
        let alertVC = GFAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentDefaultError() {
        let alertVC = GFAlertVC(alertTitle: "Something went wrong",
                                message: "We were unable to complete your task at this time. Please try again",
                                buttonTitle: "OK")
        alertVC.modalPresentationStyle = .overFullScreen
        alertVC.modalTransitionStyle = .crossDissolve
        present(alertVC, animated: true)
    }
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    
}
