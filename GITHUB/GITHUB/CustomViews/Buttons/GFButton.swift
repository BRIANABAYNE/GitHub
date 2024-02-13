//
//  GFButton.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit

// creating a custom button that I will be using throughout the app

// subclass of UIButton called GFButton
class GFButton: UIButton {
    
    // override the init since I am going to a custom button
    override init(frame: CGRect) {
        // super means I am calling the parent class or super class - calling everything that a UIButton has and then doing the custom code
        /// subclass - building onto of the existing objects
        // Building our GFButton on top on UIButton
        // GF Button is the child class of the UIButton that would be the parent class
        super.init(frame: frame)
        // calling the custom button that I created
        configure()
    }
    
    // This gets called when you initialize the button via storyboard - we aren't using storyboard , handles the init when using storyboard
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
 convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
       set(color: backgroundColor, title: title)
    }
    
    private func configure() {
        // setting up the base logic for button
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        // use autoLayout - always set to false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
    }
}
