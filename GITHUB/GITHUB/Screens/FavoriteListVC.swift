//
//  FavoriteListVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/16/24.
//

import UIKit

class FavoriteListVC: DataLoadingVC {
    
    
    let tableView = UITableView()
    var favorites: [Follower] = []
    
    // MARK: - Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        configureViewController()
        configureTableView()
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    override func updateContentUnavailableConfiguration(using state: UIContentUnavailableConfigurationState) {
        if favorites.isEmpty {
            var config = UIContentUnavailableConfiguration.empty()
            config.image = .init(systemName: "heart.slash.fill")
            config.text = "No Favorites"
            config.secondaryText = "Add a Favorite on the follower list screen"
            contentUnavailableConfiguration = config
        } else {
            contentUnavailableConfiguration = nil
        }
    }
    
    func configureTableView() {
        // add the subview
        view.addSubview(tableView)
        // fill up the whole view
        tableView.frame = view.bounds
        // setting the rowHeight
        tableView.rowHeight = 80
        // setting up the tableview - tableview need the delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        /// Removes the empty cells on the TableView 
        tableView.removeExcessCells()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseID)
    }
    
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        // making the text big on the navigation
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
            case .failure(let error):
                
                DispatchQueue.main.async {
                    self.presentGFAlert(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OKAY")
                }
            }
        }
    }
    
    
    func updateUI(with favorites: [Follower]) {
        
        //        if favorites.isEmpty {
        //            self.callEmptyStateView(with: "No favorites? \nAdd one on the follower screen.", in: self.view)
        //        } else {
        self.favorites = favorites
        setNeedsUpdateContentUnavailableConfiguration()
        DispatchQueue.main.async {
            // call reload the tableView on the main thread
            self.tableView.reloadData()
            // edge case - empty case
            self.view.bringSubviewToFront(self.tableView)
        }
    }
}

extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // number of rows in section - this will be different per user depending on how many favorites they have
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCell.reuseID) as! FavoriteCell
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite = favorites[indexPath.row]
        let destinationVC = FollowersListVC(userName: favorite.login)
//        destinationVC.userName = favorite.login
//        destinationVC.title = favorite.login
//        
        // pushing the navigation onto the stack
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        // swipe to delete
        guard editingStyle == .delete else { return }
       
        PersistenceManager.updateWith(
            favorite: favorites[indexPath.row],
            actionType: .remove) {
            [weak self] error in
            guard let self else { return }
            guard let error else { 
                self.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .left)
//                if self.favorites.isEmpty {
//                    self.callEmptyStateView(with: "No favorites?\nAdd one on the followers screen.", in: self.view)
//                }
                
                setNeedsUpdateContentUnavailableConfiguration()
                
                return
            }
            
                DispatchQueue.main.async {
                    self.presentGFAlert(alertTitle: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OKAY")
                }
        }
    }
}
