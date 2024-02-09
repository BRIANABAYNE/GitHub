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
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)

  
    }
    
    private func configure() {
        layer.cornerRadius = 10
        setTitleColor(.white, for: .normal)
        // using this for a dynamic type font, dynamic type is where the user can change the size of the font in their phone. If you don't use a dynamic type font, the user will not be able to change the font size. This is something that is built into the apple iPhone.
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        // use autoLayout - always set to false
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor: UIColor, title: String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
