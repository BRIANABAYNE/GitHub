//
//  UIView + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/8/24.
//

import UIKit



extension UIView {
    
    /// Variadic Parameters - Converts into an array
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
