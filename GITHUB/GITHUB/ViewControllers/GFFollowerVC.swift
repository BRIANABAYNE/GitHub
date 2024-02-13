//
//  GFFollowerVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/5/24.
//

import UIKit


protocol GFFollowersVCDelegate: AnyObject {
    
    func didTapGetFollowers(for user: User)
}

class GFFollowerVC: GFItemInfoVC {
    
    weak var delegate: GFFollowersVCDelegate!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    init(user: User, delegate: GFFollowersVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Git Followers")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
    
}

