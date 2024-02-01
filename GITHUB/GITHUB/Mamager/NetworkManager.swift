//
//  NetworkManager.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/1/24.
//

import Foundation

class NetworkManager {
    
    // singlton - shared instance throughout the app - static mean we can access this property throughout the app.
    static let shared = NetworkManager()
    let baseURL = "https://api.github.com/users/"
    private init() {
        
    }
    
    func getFollowers(for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
        let endpoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        // using guard let because it returns an optional
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUsername))
            return
        }
        // URL Session 
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _  = error {
                completed(.failure(.unableToComplete))
                return
            }
            // checking for data "response" - if we have a response, then we are checking to make sure that response is returning with 200, 200 is what we are getting back from the network call.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do { let decoder = JSONDecoder()
                // decoding from snake case from our model - instead of using coding keys in our model.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(.success(followers))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
