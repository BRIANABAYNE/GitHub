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
    
    func getFollowers(for userName: String, page: Int, completed: @escaping ([Follower]?, String?) -> Void) {
        let endpoint = baseURL + "/users/\(userName)/followers?per_page=100&page=\(page)"
        // using guard let because it returns an optional
        guard let url = URL(string: endpoint) else {
            completed(nil, "This user name created an invalid request.")
            return
        }
        // URL Session 
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let _  = error {
                completed(nil, "Unable to complete your request")
                return
            }
            // checking for data "response" - if we have a response, then we are checking to make sure that response is returning with 200, 200 is what we are getting back from the network call.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(nil, "Invalid response from the server")
                return
            }
            guard let data = data else {
                completed(nil, "The data received from the server")
                return
            }
            
            do { let decoder = JSONDecoder()
                // decoding from snake case from our model - instead of using coding keys in our model.
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let followers = try decoder.decode([Follower].self, from: data)
                completed(followers,nil)
            } catch {
                completed(nil, "ERROR")
            }
        }
        
        task.resume()
    }
}