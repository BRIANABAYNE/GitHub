//
//  GFFollowerVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/5/24.
//

import UIKit

// MARK: - Protocol

protocol GFFollowersVCDelegate: AnyObject {
    func didTapGetFollowers(for user: User)
}

class GFFollowerVC: GFItemInfoVC {
    
    // MARK: - Properties
    
    weak var delegate: GFFollowersVCDelegate!
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    // MARK: - Initializers
    
    init(user: User, delegate: GFFollowersVCDelegate) {
        super.init(user: user)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Functions
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following, withCount: user.following)
        actionButton.set(color: .systemGreen, title: "Git Followers", systemImageName: "person.3")
    }
    
    override func actionButtonTapped() {
        delegate.didTapGetFollowers(for: user)
    }
}
