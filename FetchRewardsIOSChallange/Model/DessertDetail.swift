//
//  DessertDetail.swift
//  FetchRewardsIOSCodingChallange
//
//  Created by Emre Yasa on 4/6/22.
//

import Foundation


struct APIResponseForDessert:Decodable {
    var meals: [DessertsById]
}

struct DessertsById: Decodable {
    var name:String
    var id:String
    var instructions:String
    var mealThumb:String
    var ingredients:String?
    var measures:String?
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case mealThumb = "strMealThumb"
        case id = "idMeal"
        case instructions = "strInstructions"
        case ingredients = "strIngredient3"
        case measures = "strMeasure1"
    }
    
   
}
    
    

