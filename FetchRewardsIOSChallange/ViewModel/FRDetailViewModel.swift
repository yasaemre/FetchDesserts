//
//  FRDetailViewModel.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation

class FRDetailViewModel {
    let title:String?
    let imageURL:URL?
    let idMeal:String
    let ingredients:String?
    let instructions:String?
    var imageData:Data? = nil
    
    //Dependency Injection
    init(dessert: DessertsById) {
        self.title = dessert.name
        self.imageURL = URL(string: dessert.urlToImage)
        self.idMeal = dessert.id
        self.ingredients = dessert.getIngredients()
        self.instructions = dessert.instructions
    }
}
