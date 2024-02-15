//
//  FollowerCell.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/1/24.
//

import UIKit
import SwiftUI

class FollowerCell: UICollectionViewCell {
    
   // MARK: - Properties
    
    static let reuseID = "FollowerCell"

    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Function
    
    func set(follower: Follower) {
            contentConfiguration = UIHostingConfiguration {
                FollowerView(follower: follower)
            }
    }
}
