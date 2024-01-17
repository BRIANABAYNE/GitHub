//
//  SceneDelegate.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/16/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
      
        guard let windowScene = (scene as? UIWindowScene) else { return}
        
        // rootVC for search VC
//        let searchNC = UINavigationController(rootViewController: SearchVC())
        
        // rootVC for favoriteListVC
//        let favoritesNC = UINavigationController(rootViewController: FavoriteListVC())
        
        
        // tab bar controller is holding on onto the navigation controller - witch is holding the VC
       // let tabbar = UITabBarController()
     //  tabbar.viewControllers = [searchNC, favoritesNC]
        
        
        // will take up the whole screen
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        // every window has a windowScene
        window?.windowScene = windowScene
        // creating the ViewController - removing this to replace a tab bar controller
//        window?.rootViewController = ViewController()
        
        // creating the table controller - place holder for now - hold the navigation controller
        window?.rootViewController = createTabBar()
        // will make the VC Visible on the screen
        window?.makeKeyAndVisible()
        configureNavigationBar()
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
    
    func createTabBar() -> UITabBarController {
        let tabbar = UITabBarController()
        // the overall appearance of tabbar
        UITabBar.appearance().tintColor = .systemGreen
        // tabbar just created is the vc = an array of viewControllers
        tabbar.viewControllers = [createSearchNC(), createFavoritesNC()]
        
        return tabbar
    }
    
    
    func configureNavigationBar() {
        UINavigationBar.appearance().tintColor = .systemGreen
    }
    
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

