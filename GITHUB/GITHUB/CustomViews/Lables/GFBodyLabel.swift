//
//  GFBodyLabel.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit

class GFBodyLabel: UILabel {
    
    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
         configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
    }
    
    // MARK: - Functions
    
    private func configure() {
        textColor = .secondaryLabel
        font = UIFont.preferredFont(forTextStyle: .body)
        adjustsFontForContentSizeCategory = true
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoConstraints = false
    }
}
