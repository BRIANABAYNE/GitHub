//
//  FollowersListVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit

class FollowersListVC: UIViewController {
    
    // MARK: - Properties
    // using this string to get the data from the pervious screen
    var userName: String!

    
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = false
        // creating a large title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}
