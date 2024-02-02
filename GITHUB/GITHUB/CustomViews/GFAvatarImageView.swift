//
//  GFAvatarImageView.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/1/24.
//

import UIKit

class GFAvatarImageView: UIImageView {
                                           // using a bang here because I know I have the image in my supporting files.
//   let placeholderImage = UIImage(named: "avatar-placeholder")!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
//        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self]  data, response, error in
            // guarding self because it now optional since I used weak self, weak self is always optional 
           guard let self = self else { return }
            if error != nil { return }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else { return }
            guard let data = data else { return }
            
            guard let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
        // what actually calls the URLSESSION
        task.resume()
    }
}
