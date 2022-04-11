//
//  FRDessertCellViewModel.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation

class FRDessertCellViewModel {
    let title:String?
    let imageURL:URL?
    let idMeal:String
    var imageData:Data? = nil
    
    //Dependency Injection
    init(meals: Meals) {
        self.title = meals.name
        self.imageURL = URL(string: meals.urlToImage ?? "")
        self.idMeal = meals.idMeal
    }
}
