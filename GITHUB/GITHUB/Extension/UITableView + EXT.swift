//
//  UITableView + EXT.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/8/24.
//

import UIKit

extension UITableView {

    // MARK: - Function
    
    func reloadDataOnMainThread() {
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells() {
        tableFooterView = UIView(frame: .zero)
    }
}
