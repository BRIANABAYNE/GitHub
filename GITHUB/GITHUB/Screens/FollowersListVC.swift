//
//  FollowersListVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit

class FollowersListVC: UIViewController {
    
    // MARK: - Enum
    // using this for DiffableDataSource - Hash function, takes in a value like a user Name and gives it a fixed value, similar to UUID. This datsource is using a hash function
    
    // ENUM are Hashable by default
    enum Section {
        case main
    }
    
    // MARK: - Properties
    // using this string to get the data from the pervious screen
    var userName: String!
    // initializing our collectionView
    var collectionView: UICollectionView!
    // property for the dataSource
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    var page = 1
    var hasMoreFollowers = true
    var isSearching = false
    
    //initialized an empty array of followers
    var followers: [Follower] = []
    
    var filterFollowers: [Follower] = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureViewController()
        getFollowers(userName: userName, page: page)
        configureDataSource()
        configureSearchController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        collectionView.delegate = self
        // using the object that I initialized
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    func configureViewController() {
        navigationController?.isNavigationBarHidden = false
        // creating a large title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func getFollowers(userName: String, page: Int) {
        // every time you are using weak self, it's going to make it optional, using weak self to handle the memory leaks, capture list = WEAK SELF - weak is optional
        showLoadingView()
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
            
            // unwrapping the optional of self to remove all of the ? I added to self because weak self made self optional
            guard let self = self else { return }
            self.dismissLoadingView()
            switch result {
            case .success(let followers):
                if followers.count < 100 {self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                // make sure we have the array of followers
                
                if self.followers.isEmpty {
                    let message = "This user doesn't have any followers. Go follow them! 🫶🏻🫶🏻"
                    DispatchQueue.main.async {
                        self.callEmptyStateView(with: message, in: self.view)
                    }
                    
                    return
                }
                
                self.updateData(on: self.followers)
            case .failure(let error):
                self.presentGFAlertOnMainThread(alertTitle: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
            }
        }
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            // creating the cell - then type casting the cell with the cell I need "FollowerCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID, for: indexPath) as! FollowerCell
            // configure the cell with the follower
            cell.set(follower: follower)
            // return the cell
            return cell
        })
    }
    
    func updateData(on followers: [Follower]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        // creating from line 29
        snapshot.appendItems(followers)
        // Make sure to always call on the main thread - all UI changes have to be on the main thread
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray =  isSearching ? filterFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = UserInfoVC()
        present(destinationVC, animated: true) 
    }
}

extension FollowersListVC: UISearchResultsUpdating, UISearchBarDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { return }
        isSearching = true
        filterFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filterFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}
