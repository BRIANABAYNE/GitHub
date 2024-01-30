//
//  UIViewController + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/30/24.
//

import UIKit

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
}
