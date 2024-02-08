//
//  GFRepoVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//

import UIKit



protocol GFRepoItemVCDelegate: AnyObject {
    
    func didTapGitFollowers(for user: User)
}

class GFRepoVC: GFItemInfoVC {
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    weak var delegate: GFRepoItemVCDelegate!
    
    // MARK: - Methods
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backGroundColor: .systemPurple, title: "Github Profile")
        
    }
    
    override func actionButtonTapped() {
        delegate.didTapGitFollowers(for: user)
    }
    
}
