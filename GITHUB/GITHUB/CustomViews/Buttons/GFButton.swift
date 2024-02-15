//
//  GFButton.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit


class GFButton: UIButton {
    
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(color: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
     set(color: color, title: title, systemImageName: systemImageName)
    }
    
    // MARK: - Functions
    
    private func configure() {
        configuration = .tinted()
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(color: UIColor, title: String, systemImageName: String) {
        configuration?.baseBackgroundColor = color
        configuration?.baseForegroundColor = color
        configuration?.title = title
        configuration?.image = UIImage(systemName: systemImageName)
        configuration?.imagePadding = 6
        configuration?.imagePlacement = .leading
    }
}

#Preview {
    return GFButton(color: .systemPink, title: "Happy Valentine's Day", systemImageName: "Heart")
}
