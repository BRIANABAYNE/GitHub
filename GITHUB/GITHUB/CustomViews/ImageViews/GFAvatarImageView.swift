//
//  GFAvatarImageView.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/1/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
  
    // MARK: - Properties
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(fromURL url: String) {
        Task {
            image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage
        }
    }
}
