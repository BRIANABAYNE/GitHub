//
//  UIHelper.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/2/24.
//

import UIKit

enum UIHelper {
    // creating how the collectionView will look
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
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
}
