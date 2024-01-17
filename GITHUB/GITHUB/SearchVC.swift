//
//  SearchVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/16/24.
//

import UIKit

class SearchVC: UIViewController {
    
    // MARK: - Properties
    
    let logoImageView = UIImageView()
    let userNameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    // MARK: - Lifecycles
// view didload only gets called once
    override func viewDidLoad() {
        super.viewDidLoad()
        // calling this to use for either dark mode or light mode , will adapt
        view.backgroundColor = .systemBackground
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
    }
    
    // whenever you are overriding something, most of the time you will want to call the super. This is what happens every time view will appear
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    func configureLogoImageView() {
        // calling our property that I made on line 14 inside of the subView
        view.addSubview(logoImageView)
        // auto layout
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        // constraints - 4 constraints per object - an array of constraints
        // X,Y, Height, Width ( The 4 Constraints ) X is in the middle of the screen, Y is the
        NSLayoutConstraint.activate([
            // pinning to the top - to the safe area
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            // centering it to the X (center this in the VIEW )
            // Y = top, X = side to side
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            // height
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            // width
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
            ])
    }
    
    
    func configureTextField() {
        // passing in the property that was made on line 15
        view.addSubview(userNameTextField)
        NSLayoutConstraint.activate([
            // pinning it to the bottom of the logoImageView with 48 - Y
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 48),
            // adding the constraints to each side
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            // apple says buttons should be at least 44 points high per the human interface guidelines
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    
    func configureCallToActionButton() {
        // This is actually putting the button on the screen
        view.addSubview(callToActionButton)
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            ])
    }
    
    
    
}
