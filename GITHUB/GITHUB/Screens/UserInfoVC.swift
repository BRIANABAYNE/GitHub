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

    let scrollView = UIScrollView()
    let contentView = UIView()
    
    
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
        configureScrollView()
        layoutUI()
        getUserInfo()
    
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissMissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 620)
        ])
    
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
     
        self.add(childVC: GFRepoVC(user: user, delegate: self), to: self.itemViewOne)
        self.add(childVC: GFFollowerVC(user: user, delegate: self), to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headerView)
        self.dateLabel.text = "GitHub member since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI() {
        
        let padding: CGFloat = 20
        let itemHeight: CGFloat = 140
        
        itemViews = [headerView, itemViewOne, itemViewTwo, dateLabel]
        
        for itemView in itemViews {
            contentView.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                itemView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding),
                itemView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding),
            ])
        }
        
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
        
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 210),
            
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
    func didTapGitHubProfile(for user: User) {
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
    
