//
//  PersistenceManager.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/5/24.
//

import Foundation

// adding or remove favorites
enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    
    // instance of UserDefaults
    static private let defaults = UserDefaults.standard
    
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(
        favorite: Follower,
        actionType: PersistenceActionType,
        completion: @escaping (GFError?) -> Void
    ){
        retrieveFavorites { result in
            switch result {
            case .success(let favorites):
                // adding a temp array
                var retrievedFavorites = favorites
                // switching on two types, case add or case remove
                switch actionType {
                case .add:
                    // don't add a favorite if it already is in the favorites. Make sure it doens't contain that favorite
                    guard !retrievedFavorites.contains(favorite) else {
                        // completion with an alert that says, that person is already added to your favorites -
                        // return out of the function
                        completion(.alreadyInFavorites)
                        return
                    }
                    // if that user isn't already favorited, then adding that person to the favorite array "append, equals add"
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    // removing the favorite - $0 is each item iterating through the array - remove any instance where the login equals the favorites, thats where it will be removed - swipe to delete
                    retrievedFavorites.removeAll { $0.login == favorite.login }
                }
                // saving the array of favorites to userDefaults 
                completion(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    
    // completion handler and error type - an array of follower or GFError, GF Error is the custom error that I created
    static func retrieveFavorites(completed: @escaping (Result<[Follower], GFError>) -> Void) {
        
        // accessing the "defaults" - the constant that I created for the userDefaults - userDefaults needs a key - this is data, else return an empty array, because this is the first time you are trying to access it
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        
        do { 
            // decoding
            let decoder = JSONDecoder()
            // decoding from snake case from our model - instead of using coding keys in our model.
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completed(.success(favorites))
        } catch {
            completed(.failure(.unableToFavorite))
        }
    }
    
  // saving the favorites of [] // encoding
    static func save(favorites: [Follower]) -> GFError? {
        
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            // saving to the userDefaults
            defaults.set(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
