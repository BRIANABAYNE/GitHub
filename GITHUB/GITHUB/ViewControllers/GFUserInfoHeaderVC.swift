//
//  GFUserInfoHeaderVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {
    
// This is a child View Controller
    
    // MARK: - Properties
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let userNameLabel = GFTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel = GFSecondaryTitleLabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel = GFSecondaryTitleLabel(fontSize: 18)
    let bioLabel = GFBodyLabel(textAlignment: .left)
 
    // Getting a user object
    var user: User!
    
    
    // creating a custom init, so when I initialize this VC, I can pass in a user, set that user, and then whatever user I pass in, I'm going to set the avatar, userName, userLocation.
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    // Required Storyboard Init
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView()
        layoutUI()
        configureUIElements()
    }
    
    
    
    func configureUIElements() {
        // setting the information
        avatarImageView.downloadImage(fromURL: user.avatarUrl)
        userNameLabel.text = user.login
        // name is optional - use nil coal - if userName is blank then use this string - PLACEHOLDER
        nameLabel.text = user.name ?? "No name"
        locationLabel.text = user.location ?? "No Location"
        bioLabel.text = user.bio ?? "No bio available"
        bioLabel.numberOfLines = 3
        locationImageView.image = SFSymbols.location 
        locationImageView.tintColor = .secondaryLabel
    
    }
    

    
    func addSubView() {
      view.addSubviews(avatarImageView, userNameLabel, nameLabel, locationImageView, locationLabel, bioLabel)
        // replacing all these lines of code with one line of code. Leaving in here so my future self remembers.
//        view.addSubview(avatarImageView)
//        view.addSubview(userNameLabel)
//        view.addSubview(nameLabel)
//        view.addSubview(locationImageView)
//        view.addSubview(locationLabel)
//        view.addSubview(bioLabel)
    }
    
    func layoutUI() {
        let padding: CGFloat = 20
        // This text is going to be 12 from the avatarImage
        let textImagePadding: CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            // All these constraints are based off of the avatarImageView - pinning the image first because that's what all the other constraints are going off of. the top anchor will be 20 for the view, we are creating a container for the view on another file, userInfoVC
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            // 20 from the left
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            // making it a square
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            // making it a square
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            
            
            // Lining up the top of the nameLabel to the top of the avatarImageView - so the tops will be align
            userNameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            // Pinning this to the right side of the avatarImage - right side
            userNameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            
            // pinning to the view - going all the right side of the view
            userNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            // have to make the label a little bigger because of the Y,J,Q
            userNameLabel.heightAnchor.constraint(equalToConstant: 38),
            
            
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
}
