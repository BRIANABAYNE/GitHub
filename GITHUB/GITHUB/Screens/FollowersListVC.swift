//
//  FollowersListVC.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/17/24.
//

import UIKit




class FollowersListVC: DataLoadingVC {
    
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
    var isLoadingMoreFollowers = false
    var followers: [Follower] = []
    
    var filterFollowers: [Follower] = []
    
    
    init(userName: String) {
        super.init(nibName: nil, bundle: nil)
        self.userName = userName
        title = userName
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //initialized an empty array of followers
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureSearchController()
        configureViewController()
        getFollowers(userName: userName, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        // using the object that I initialized
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    
    func configureSearchController() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
//        navigationController?.isNavigationBarHidden = false
        // creating a large title
        
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem = addButton
    }
    
    func getFollowers(userName: String, page: Int) {
        // every time you are using weak self, it's going to make it optional, using weak self to handle the memory leaks, capture list = WEAK SELF - weak is optional
        showLoadingView()
        isLoadingMoreFollowers = true
        
        // Task puts you into a concurrency context - this is Structured
        Task {
            do {
                // success
                let followers = try await NetworkManager.shared.getFollowers(for: userName, page: page)
                updateUI(with: followers)
                dismissLoadingView()
            } catch {
                // handle the error here
                if let gfError = error as? GFError {
                    presentGFAlert(alertTitle: "Bad Stuff Happened", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                
                dismissLoadingView()
            }
        }
        
        
        /// If I didn't have a custom error, I would handle the code this way - INSIDE of the TASK
//        guard let followers = try ? await NetworkManager.shared.getFollowers(userName: userName, page: page) else {
//            presentDefaultError()
//            dismissLoadingView()
//            return
//        }
//        
//        updateUI(with: followers)
//        dismissLoadingView()
//        
//    }
        
/// OLD WAY - Not Structured
//        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] result in
//            
//            // unwrapping the optional of self to remove all of the ? I added to self because weak self made self optional
//            guard let self = self else { return }
//            self.dismissLoadingView()
//            
//            switch result {
//            case .success(let followers):
//                self.updateUI(with: followers)
//                
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(alertTitle: "Bad Stuff Happened", message: error.rawValue, buttonTitle: "OK")
//            }
//            
//            self.isLoadingMoreFollowers = false
//        }
    }
    

    func updateUI(with followers: [Follower]) {
        if followers.count < 100 { self.hasMoreFollowers = false }
        self.followers.append(contentsOf: followers)
        // make sure we have the array of followers
        
        if self.followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them! 🫶🏻🫶🏻"
            DispatchQueue.main.async {
                self.callEmptyStateView(with: message, in: self.view)
                return
            }
            
        }
        
        self.updateData(on: self.followers)
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
    
    @objc func addButtonTapped() {
        showLoadingView()
        
        
        Task {
            do {
                let user = try await NetworkManager.shared.getUserInfo(for: userName)
                addUserToFavorites(user: user)
                dismissLoadingView()
            } catch {
                if let gfError = error as? GFError {
                    presentGFAlert(alertTitle: "Something went wrong", message: gfError.rawValue, buttonTitle: "OK")
                } else {
                    presentDefaultError()
                }
                
                dismissLoadingView()
            }
        }
    }
//        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
//            guard let self = self else { return }
//            self.dismissLoadingView()
//            switch result {
//            case .success(let user):
//                self.addUserToFavorites(user: user)
//            case .failure(let error):
//                self.presentGFAlertOnMainThread(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OKAY")
//            }
//        }
//    }
    
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
    
    
    func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] error in
            guard let self = self else { return }
            guard let error = error else  {
                DispatchQueue.main.async {
                    self.presentGFAlert(alertTitle: "Success!", message: "You have successfully favorited this user! ", buttonTitle: "YAYA")
                }
                
                return
            }
            
            DispatchQueue.main.sync {
                self.presentGFAlert(alertTitle: "Something went wrong", message: error.rawValue, buttonTitle: "OKAY")
            }
        }
        
    }
    
    
    
    
}

extension FollowersListVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        // pagination code // are we at the bottom, lets call in more followers, so we aren't making another network call.
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers
            else { return }
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray =  isSearching ? filterFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let destinationVC = UserInfoVC()
        destinationVC.userName = follower.login
        destinationVC.delegate = self
        let navController = UINavigationController(rootViewController: destinationVC)
        present(navController, animated: true)
    }
}

extension FollowersListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else { 
            filterFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        
        isSearching = true
        filterFollowers = followers.filter { $0.login.lowercased().contains(filter.lowercased()) }
        updateData(on: filterFollowers)
    }
}

extension FollowersListVC: UserInfoVCDelegate {
    
    func didRequestFollowers(for userName: String) {
        self.userName = userName
        title = userName
        page  = 1
        followers.removeAll()
        filterFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(userName: userName, page: page)
    }

}
