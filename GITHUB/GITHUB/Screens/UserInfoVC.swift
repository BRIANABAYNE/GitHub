//
//  UserInfoVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//

import UIKit

class UserInfoVC: UIViewController {
    
    var userName: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dissMissVC))
        navigationItem.rightBarButtonItem = doneButton
        print(userName!)
    }
    
    @objc func dissMissVC() {
        dismiss(animated: true)
    }
}
