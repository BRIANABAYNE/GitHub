//
//  GFFollowerVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/5/24.
//

import UIKit


class GFFollowerVC: GFItemInfoVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(backGroundColor: .systemGreen, title: "Git Followers")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
}

