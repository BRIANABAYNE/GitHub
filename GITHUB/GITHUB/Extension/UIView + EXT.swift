//
//  UIView + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/8/24.
//

import UIKit


extension UIView {
    
    // MARK: - Function
    
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }

    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
