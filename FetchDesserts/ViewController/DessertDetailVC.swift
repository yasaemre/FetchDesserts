//
//  DetailVC.swift
//  FetchDesserts
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation
import UIKit

class DessertDetailVC:UIViewController {
    let detailView = FRDessertDetailView(frame: UIScreen.main.bounds)
    var dessertViewModel = [FRDessertDetailViewModel]()
    let activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUPDetailView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadActivityIndicator()
        fetchDessertById()
    }
    
    private func setUPDetailView() {
        view.addSubview(detailView)
        view.backgroundColor = .systemBackground
    }
    
    private func fetchDessertById() {
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
        APICaller.shared.fetchDessert(for: detailView.mealID) { [weak self] result in
            switch result {
            case.success(let meal):
                self?.dessertViewModel = meal.compactMap({
                    FRDessertDetailViewModel(dessert: $0)
                })
                
                DispatchQueue.main.async {
                    if let title = (meal.first?.name) {
                        self?.title = title
                    }
                    
                    self?.detailView.configure(with: self?.dessertViewModel ?? [])
                    self?.activityIndicator.stopAnimating()
                    self?.view.isUserInteractionEnabled = true
                }
                
            case .failure(_):
                fatalError()
            }
        }
    }
}

extension DessertDetailVC {
    private func loadActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.backgroundColor = .darkGray
        activityIndicator.style = .large
        activityIndicator.color = .darkGray
        view.addSubview(activityIndicator)
    }
}
