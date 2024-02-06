//
//  GFTabBarController.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/6/24.
//

import UIKit

class GFTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen
        viewControllers = [createSearchNC(), createFavoritesNC()]
    }
    
    

    func createSearchNC() -> UINavigationController {
        // init the SearchVC
        let searchVC  = SearchVC()
        // giving it a title
        searchVC.title = "Search"
        // adding the system image
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        // returning a navigationController that we just created
        return UINavigationController(rootViewController: searchVC)
        
    }
    
    func createFavoritesNC() -> UINavigationController {
        // init the FavoriteListVC
        let favoriteListVC = FavoriteListVC()
        // Give it a title
        favoriteListVC.title = "Favorites"
        // tabbar and
        favoriteListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        return UINavigationController(rootViewController: favoriteListVC)
        
    }
}
