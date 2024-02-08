//
//  UIView + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/8/24.
//

import UIKit



extension UIView {
    
    /// Variadic Parameters
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
