//
//  NetworkManager.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/1/24.
//

import UIKit

class NetworkManager {
    
    // singleton - shared instance throughout the app - static mean we can access this property throughout the app.

    static let shared = NetworkManager()
    private let baseURL = "https://api.github.com/users/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    
    private init() {
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .iso8601
    }
    // closures are either @escaping or not escaping - escaping can outlive this function "getfollowers" the closure can be called after a period of time. closure has to outlive the function, we go to the network, we get the data, the function is called and depending on the wifi, the function might have already happened so that's why we need at escaping, need time to get the data. CLOSUREs are none escaping by default -- At escaping is called after the function is called.
    
    /// OLD WAY OF DOING NETWORK CALLS
//    func getFollowers(for userName: String, page: Int, completed: @escaping (Result<[Follower], GFError>) -> Void) {
//        let endpoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
//        // using guard let because it returns an optional
//        guard let url = URL(string: endpoint) else {
//            completed(.failure(.invalidUsername))
//            return
//        }
//        // URL Session
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            if let _  = error {
//                completed(.failure(.unableToComplete))
//                return
//            }
//            // checking for data "response" - if we have a response, then we are checking to make sure that response is returning with 200, 200 is what we are getting back from the network call.
//            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
//                completed(.failure(.invalidResponse))
//                return
//            }
//            guard let data = data else {
//                completed(.failure(.invalidData))
//                return
//            }
//
//            do { let decoder = JSONDecoder()
//                // decoding from snake case from our model - instead of using coding keys in our model.
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//                // super common to see .iso8601 - taking a certain object and turning it into a date - this is now taking care of our date, I no longer need that string extension because this taking the format of yyyy-MM-dd'T'HH:mm:ssZ and translating it into a date
//               // decoder.dateDecodingStrategy = .iso8601
//                let followers = try decoder.decode([Follower].self, from: data)
//                completed(.success(followers))
//            } catch {
//                completed(.failure(.invalidData))
//            }
//        }
//
//        task.resume()
//    }
    
    
    func getFollowers(for userName: String, page: Int) async throws -> [Follower] {
        
        let endpoint = baseURL + "\(userName)/followers?per_page=100&page=\(page)"
        // using guard let because it returns an optional
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        
        // returns a tuple
        let(data, response) = try await URLSession.shared.data(from: url)
        // URL Session - new way
        
        // checking for data "response" - if we have a response, then we are checking to make sure that response is returning with 200, 200 is what we are getting back from the network call.
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw GFError.invalidResponse
        }
        
        do {
            
            return try decoder.decode([Follower].self, from: data)
        } catch {
            throw GFError.invalidData
        }
    }

    
    func getUserInfo(for userName: String) async throws -> User {
        let endpoint = baseURL + "\(userName)"
        // using guard let because it returns an optional
        guard let url = URL(string: endpoint) else {
            throw GFError.invalidUsername
        }
        // URL Session
        let(data, response) = try await URLSession.shared.data(from: url)
         
            // checking for data "response" - if we have a response, then we are checking to make sure that response is returning with 200, 200 is what we are getting back from the network call.
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw GFError.invalidResponse
            }
        
            do {
            
               return try decoder.decode(User.self, from: data)
            } catch {
                throw GFError.invalidData
            }
        }


    func downloadImage(from urlString: String) async throws -> UIImage {
        
        let cacheKey = NSString(string: urlString)
        
        if let image = cache.object(forKey: cacheKey) {
            throw GFError.invalidImage
        }
        
        guard let url = URL(string: urlString) else {
            throw GFError.invalidData
        }
        
        let(data, response) = try await URLSession.shared.data(from: url)
        
        
            // guarding self because it now optional since I used weak self, weak self is always optional
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            
            self.cache.setObject(image, forKey: cacheKey)
             completion(image)
            }
            // what actually calls the URLSESSION
            task.resume()
        }
    }
