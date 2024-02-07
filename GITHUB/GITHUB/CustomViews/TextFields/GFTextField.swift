//
//  GFTextField1.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit

class GFTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
    }
    
    // storyboard init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureText() {
        // need this for the constrains, always set to false
        translatesAutoresizingMaskIntoConstraints = false
        // edge of the textField
        layer.cornerRadius = 10
        layer.borderWidth = 2
        layer.borderColor = UIColor.systemGray4.cgColor
        
        textColor = .label
        tintColor = .label
        textAlignment = .center
        font = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth = true
        minimumFontSize = 12
        
        backgroundColor = .tertiarySystemBackground
        // This is auto correct when a user is typing, this wouldn't be needed since we user will be typing in a name and we wouldn't want it to auto correct.
        autocorrectionType = .no
        // costume the return type on the keyboard 
        returnKeyType = .go
        // adds a X when typing to exit 
        clearButtonMode = .whileEditing
        placeholder = "Enter a username"
        
    }
}
