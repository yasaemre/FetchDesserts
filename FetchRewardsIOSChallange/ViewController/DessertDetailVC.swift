//
//  DetailVC.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation
import UIKit

class DessertDetailVC:UIViewController {
    let detailView = FRDetailView(frame: UIScreen.main.bounds)
    var mealViewModel = [FRDetailByIdViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchDessertById()
    }
    
    private func setUPDetailView() {
        view.addSubview(detailView)
        view.backgroundColor = .systemBackground
    }
    
    private func fetchDessertById() {
        APICaller.shared.fetchDessert(for: detailView.mealID) { [weak self] result in
            switch result {
            case.success(let meal):
                self?.mealViewModel = meal.compactMap({
                    FRDetailByIdViewModel(dessert: $0)
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
}
