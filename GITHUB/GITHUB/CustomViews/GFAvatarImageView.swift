//
//  GFAvatarImageView.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/1/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
                                           // using a bang here because I know I have the image in my supporting files.
    let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
