//
//  UserInfoVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//

import UIKit

protocol UserInfoVCDelegate: AnyObject {
    func didRequestFollowers(for userName: String)
}

class UserInfoVC: DataLoadingVC {

    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var userName: String!
    weak var delegate: UserInfoVCDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        getUserInfo()
        layoutUI()
    
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissMissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OKAY")
            }
        }
    }
    
    func configureUIElements(with user: User) {
        
        let repoItemVC = GFRepoVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerVC(user: user)
        followerItemVC.delegate = self
        
        
        self.add(childVC: repoItemVC, to: self.itemViewOne)
        self.add(childVC: followerItemVC, to: self.itemViewTwo)
        self.add(childVC: GFFollowerVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub member since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        let headerViewOne: CGFloat = 180
        
        itemViews = [ headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemsViews in itemViews {
            view.addSubview(itemsViews)
            itemsViews.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemsViews.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                itemsViews.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            ])
        }
        
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: headerViewOne),
            
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 50)
            
        ])
    }
    
    func add(childVC: UIViewController, to containView: UIView) {
        addChild(childVC)
        containView.addSubview(childVC.view)
        childVC.view.frame = containView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dissMissVC() {
        dismiss(animated: true)
    }
}


extension UserInfoVC: GFRepoItemVCDelegate {
    
    func didTapGitFollowers(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(
                alertTitle: "Invalid URL",
                message: "The url attached to this user is invalid.",
                buttonTitle: "OKAY")
            return
        }
        
        presentSafariVC(with: url)
    }
    
}

extension UserInfoVC: GFFollowersVCDelegate {
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentGFAlertOnMainThread(
                alertTitle: "No followers",
                message: "This user has no followers. Go Follow Them <3 ",
                buttonTitle:"OKAY")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dissMissVC()
    }
    
}
    
