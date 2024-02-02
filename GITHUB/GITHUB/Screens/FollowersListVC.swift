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
    
    //initialized an empty array of followers
    var followers: [Follower] = []
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureCollectionView()
        configureViewController()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        // using the object that I initialized
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    func configureViewController() {
        navigationController?.isNavigationBarHidden = false
        // creating a large title
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    // creating how the collectionView will look
    func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout {
        // the view is the total width of the VC
        let width = view.bounds.width
        // the padding from the sides
        let padding: CGFloat = 12
        // the padding around all sides
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    
    func getFollowers() {
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            switch result {
            case .success(let followers):
                self.followers = followers
                // make sure we have the array of followers
                self.updateData()
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
    
    func updateData() {
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
