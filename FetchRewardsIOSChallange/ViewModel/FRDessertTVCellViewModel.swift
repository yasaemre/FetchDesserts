//
//  FRDessertTVCellViewModel.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation

class FRDessertTVCellViewModel {
    let title:String?
    let imageURL:URL?
    let idMeal:String
    var imageData:Data? = nil
    
    init(title:String?, imageURL:URL?, idMeal:String) {
        self.title = title
        self.imageURL = imageURL
        self.idMeal = idMeal
    }
}
