//
//  UserInfoVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//

import UIKit


// setting the protocol and giving the functions I need, step 1 - List of commands
protocol UserInfoVCDelegate: AnyObject {
    func didTapGitHubProfile(for user: User)
    func didTapGetFollowers(for user: User)
}

class UserInfoVC: UIViewController {

    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel = GFBodyLabel(textAlignment: .center)
    var itemViews: [UIView] = []
    
    var userName: String!
    weak var delegate: FollowerListVCDelegate! 

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
        
        itemViews = [ itemViewOne, itemViewTwo, headerView, dateLabel]
        
        for items in itemViews {
            view.addSubview(items)
            items.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                items.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
                items.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
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
            dateLabel.heightAnchor.constraint(equalToConstant: 18)
            
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

extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(alertTitle: "Invalid URL", message: "The url attached to this user is invalid.", buttonTitle: "OKAY")
            return
        }
        
        presentSafariVC(with: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else { presentGFAlertOnMainThread(alertTitle: "No followers", message: "This user has no followers. Go Follow Them <3 ", buttonTitle:"OKAY")
            return
        }
        
        delegate.didRequestFollowers(for: user.login)
        dissMissVC()
    }

}
