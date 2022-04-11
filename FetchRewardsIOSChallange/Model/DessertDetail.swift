//
//  DessertDetail.swift
//  FetchRewardsIOSChallange
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
    var urlToImage:String
    var ing1: String?
    var ing2: String?
    var ing3: String?
    var ing4: String?
    var ing5: String?
    var ing6: String?
    var ing7: String?
    var ing8: String?
    var ing9: String?
    var ing10: String?
    var ing11: String?
    var ing12: String?
    var ing13: String?
    var ing14: String?
    var ing15: String?
    var ing16: String?
    var ing17: String?
    var ing18: String?
    var ing19: String?
    var ing20: String?
    
    
    enum CodingKeys: String, CodingKey {
        case name = "strMeal"
        case urlToImage = "strMealThumb"
        case id = "idMeal"
        case instructions = "strInstructions"
        case ing1 = "strIngredient1"
        case ing2 = "strIngredient2"
        case ing3 = "strIngredient3"
        case ing4 = "strIngredient4"
        case ing5 = "strIngredient5"
        case ing6 = "strIngredient6"
        case ing7 = "strIngredient7"
        case ing8 = "strIngredient8"
        case ing9 = "strIngredient9"
        case ing10 = "strIngredient10"
        case ing11 = "strIngredient11"
        case ing12 = "strIngredient12"
        case ing13 = "strIngredient13"
        case ing14 = "strIngredient14"
        case ing15 = "strIngredient15"
        case ing16 = "strIngredient16"
        case ing17 = "strIngredient17"
        case ing18 = "strIngredient18"
        case ing19 = "strIngredient19"
        case ing20 = "strIngredient20"
        
    }
    
    func getIngredients() -> String {
        var ingredients = [String]()
        
        ingredients.append(ing1 ?? "")
        ingredients.append(ing2 ?? "")
        ingredients.append(ing3 ?? "")
        ingredients.append(ing4 ?? "")
        ingredients.append(ing5 ?? "")
        ingredients.append(ing6 ?? "")
        ingredients.append(ing7 ?? "")
        ingredients.append(ing8 ?? "")
        ingredients.append(ing9 ?? "")
        ingredients.append(ing10 ?? "")
        ingredients.append(ing11 ?? "")
        ingredients.append(ing12 ?? "")
        ingredients.append(ing13 ?? "")
        ingredients.append(ing14 ?? "")
        ingredients.append(ing15 ?? "")
        ingredients.append(ing16 ?? "")
        ingredients.append(ing17 ?? "")
        ingredients.append(ing18 ?? "")
        ingredients.append(ing19 ?? "")
        ingredients.append(ing20 ?? "")
        
        let strIngredients = ingredients.joined(separator: " ")
        return strIngredients
    }

}
    
    

