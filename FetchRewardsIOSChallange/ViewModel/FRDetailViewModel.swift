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
    
    init(title:String?, imageURL:URL?, idMeal:String, ingredients:String?, instructions:String?) {
        self.title = title
        self.imageURL = imageURL
        self.idMeal = idMeal
        self.ingredients = ingredients
        self.instructions = instructions
    }
}
