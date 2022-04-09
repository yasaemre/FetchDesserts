//
//  DetailVC.swift
//  FetchRewardsIOSCodingChallange
//
//  Created by Emre Yasa on 4/6/22.
//

import Foundation
import UIKit

class DetailVC:UIViewController {
   // static let reuseId = "DetailVC"
    let detailView = FRDetailView(frame: UIScreen.main.bounds)
    //private var viewModel: FRDetailViewModel
    var viewModel: FRDetailViewModel!
    var meal = [DessertsById]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        view.backgroundColor = .systemBackground
        //var mealdId = 0 //updata
        //print(fetchDessertsById())
        
//        self.navigationController?.isNavigationBarHidden = true
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDessertsById()
    }
    
    func fetchDessertsById() {
        print(detailView.mealID)
        APICaller.shared.fetchDessert(for: detailView.mealID) { [weak self] result in
            switch result {
            case.success(let meal):
                print(meal)
                self?.meal = meal
                DispatchQueue.main.async {
                    
                    if let title = (meal.first?.name) {
                        self?.title = title
                    }
                    if let ingredients = meal.first?.ingredients {
                        
                        self?.detailView.ingredientsLabel.text = ingredients
                    }
                    if let urlString = meal.first?.mealThumb {
                        if let imageUrl = URL(string: urlString) {
                            if let imageData = try? Data(contentsOf: imageUrl) {
                                if let image = UIImage(data: imageData) {
                                    self?.detailView.dessertImageView.image = image
                                }
                            }
                        }
                    }
                    
                    
                    
                    if let instructions = meal.first?.instructions {
                        
                        self?.detailView.instructionsLabel.text = instructions
                    }
                }
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }

}
