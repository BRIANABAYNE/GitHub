//
//  Follower.swift
//  GITHUB
//
//  Created by Briana Bayne on 1/30/24.
//

import Foundation

// needed to add Hashable for the DiffDataSource - We don't need the avatar to be hashable, only the login
struct Follower: Codable, Hashable {
    var login: String
    var avatarUrl: String
}


// MARK: - Hashable

// Example to make a property hashable - using the hash function and plugging in the login
//struct Follower: Codable, Hashable {
//    var login: String
//    var avatarURL: String
//    
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(login)
//    }
//}


