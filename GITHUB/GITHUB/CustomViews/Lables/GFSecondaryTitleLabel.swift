//
//  GFSecondaryTitleLabel.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//

import UIKit

class GFSecondaryTitleLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        
    }
    
    // storyboard init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   convenience init(fontSize: CGFloat) {
       self.init(frame: .zero)
        font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
    }
    
    private func configure() {
        textColor = .label
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.90
        // will break it up if it's to line
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoConstraints = false
    }

}
