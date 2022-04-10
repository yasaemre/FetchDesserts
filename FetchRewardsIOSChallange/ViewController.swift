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
    
    private let searchVC = UISearchController(searchResultsController: nil)
    var isFiltered = false
    private var viewModels = [FRDessertTVCellViewModel]()
    private var meals = [Meals]()
    private var filteredViewModels = [FRDessertTVCellViewModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Desserts"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchDesserts()
        createSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
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
        if isFiltered {
            return filteredViewModels.count
        } else {
            return viewModels.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FRDessertTableViewCell.reusId, for: indexPath) as? FRDessertTableViewCell else {
            fatalError()
        }
        if isFiltered {
            cell.configure(with: filteredViewModels[indexPath.row])
        } else {
            cell.configure(with: viewModels[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailVC()
        self.navigationController?.pushViewController(detailVC, animated: true)

        detailVC.detailView.mealID = isFiltered ? Int(filteredViewModels[indexPath.row].idMeal) ?? 34543 :                          Int(viewModels[indexPath.row].idMeal) ?? 34543
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltered = false
        tableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
                
        APICaller.shared.searchedDesserts(with: text) { [weak self] result in
            switch result {
            case.success(let meals):
                self?.meals = meals
                self?.isFiltered = true
                self?.filteredViewModels = meals.compactMap({
                    FRDessertTVCellViewModel(
                        title: $0.name ?? "No Name",
                        imageURL: URL(string: $0.urlToImage ?? ""),
                        idMeal: $0.idMeal
                    )
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure(let error):
                fatalError()
            }
        }
    }
}


