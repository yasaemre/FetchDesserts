//
//  Desserts.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation

struct APIResponse:Codable {
    var meals: [Meals]
}

struct Meals: Codable, Hashable {
    var name:String?
    var urlToImage:String?
    var idMeal:String
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case urlToImage = "strMealThumb"
        case idMeal = "idMeal"
    }
}
