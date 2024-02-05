//
//  GFError.swift
//  GITHUB
//
//  Created by Briana Bayne on 2/4/24.
//


import Foundation
// the string is the raw value of the enum - confirming to the protocol "Error"

enum GFError: String, Error {
    case invalidUsername = "This username created an invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data received from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this user. Please try again"
    case alreadyInFavorites = "This user is already favorited"
}
