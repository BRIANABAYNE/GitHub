//
//  FavoriteListVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/16/24.
//

import UIKit

class FavoriteListVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // system color will adapt to light mode and dark mode. 
        view.backgroundColor = .systemBlue
        
        PersistenceManager.retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                break
            }
        }
        
    }
    
}
