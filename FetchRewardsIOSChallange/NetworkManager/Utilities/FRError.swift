//
//  ErrorMessage.swift
//  FetchRewardsIOSCodingChallange
//
//  Created by Emre Yasa on 4/7/22.
//


import Foundation

enum FRError: String, Error {
    case invalidUrl         = "Invalid request. Please try again."
    case unableToComplete   = "Unable to complete your request. Please check your internet connection"
    case invalidResponse    = "Invalid response from the server. Please try again."
    case invalidData        = "The data received from the server was invalid. Please try again."
}

