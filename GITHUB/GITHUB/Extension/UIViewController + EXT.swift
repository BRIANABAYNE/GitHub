//
//  UIViewController + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/30/24.
//

import UIKit
import SafariServices

fileprivate var containerView: UIView!

extension UIViewController {
    
    // MARK: - Method
    
    func presentGFAlertOnMainThread(alertTitle: String, message: String, buttonTitle: String) {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: alertTitle, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            // fade in
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    
    func presentSafariVC(with url: URL) {
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredBarTintColor = .systemGreen
        present(safariVC, animated: true)
    }
    

    }
