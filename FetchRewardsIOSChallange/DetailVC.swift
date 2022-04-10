//
//  DetailVC.swift
//  FetchRewardsIOSCodingChallange
//
//  Created by Emre Yasa on 4/6/22.
//

import Foundation
import UIKit

class DetailVC:UIViewController {
    let detailView = FRDetailView(frame: UIScreen.main.bounds)
    //private var viewModel: FRDetailViewModel
    //var viewModel: FRDetailViewModel!
    var mealViewModel = [FRDetailViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(detailView)
        view.backgroundColor = .systemBackground
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDessertsById()
        
    }
    
    func fetchDessertsById() {
        APICaller.shared.fetchDessert(for: detailView.mealID) { [weak self] result in
            switch result {
            case.success(let meal):
                //print(meal)
                self?.mealViewModel = meal.compactMap({
                    FRDetailViewModel(dessert: $0)
                })
                
                DispatchQueue.main.async {
                    
                    if let title = (meal.first?.name) {
                        self?.title = title
                    }
                   
                    self?.detailView.configure(with: self?.mealViewModel ?? [])
                }
                
            case .failure(_):
                fatalError()
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        
    }

}
