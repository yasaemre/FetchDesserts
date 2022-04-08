//
//  ViewController.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class ViewController: UIViewController {

    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(FRDessertTableViewCell.self, forCellReuseIdentifier: FRDessertTableViewCell.reusId)
        return tableView
    }()
    
    private var viewModels = [FRDessertTVCellViewModel]()
    private var meals = [Meals]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Desserts"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchDesserts()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func fetchDesserts() {
        APICaller.shared.fetchDesserts { [weak self] result in
            switch result {
            case.success(let meals):
                self?.meals = meals
                self?.viewModels = meals.compactMap({
                    FRDessertTVCellViewModel(
                        title: $0.name ?? "No Name",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        idMeal: $0.idMeal
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FRDessertTableViewCell.reusId, for: indexPath) as? FRDessertTableViewCell else {
            fatalError()
        }
        cell.configure(with: viewModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //let meal = meals[indexPath.row]
        let detailVC = DetailVC()
        self.navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

