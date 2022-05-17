//
//  ViewController.swift
//  FetchDesserts
//
//  Created by Emre Yasa on 4/8/22.
//

import UIKit

class DessertVC: UIViewController {
    private let tableView:UITableView = {
        let tableView = UITableView()
        tableView.register(FRDessertTableViewCell.self, forCellReuseIdentifier: FRDessertTableViewCell.reusId)
        return tableView
    }()
    
    private let searchVC = UISearchController(searchResultsController: nil)
    private var isFiltered = false
    private var viewModels = [FRDessertCellViewModel]()
    private var filteredViewModels = [FRDessertCellViewModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        fetchDesserts()
        createSearchBar()
    }
    
    private func setUpTableView() {
        title = "Desserts"
        view.backgroundColor = .systemBackground
        tableView.frame = view.bounds
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func createSearchBar() {
        navigationItem.searchController = searchVC
        searchVC.searchBar.delegate = self
    }
}

extension DessertVC: UITableViewDelegate, UITableViewDataSource {
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
        let detailVC = DessertDetailVC()
        self.navigationController?.pushViewController(detailVC, animated: true)
        if isFiltered {
            detailVC.detailView.mealID = Int(filteredViewModels[indexPath.row].idMeal) ?? 52772
        } else {
            detailVC.detailView.mealID = Int(viewModels[indexPath.row].idMeal) ?? 52772
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return view.frame.height / 5
    }
}

extension DessertVC: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isFiltered = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, !text.isEmpty else {
            return
        }
        
        searchedDesserts(search:text)
    }
    
    private func fetchDesserts() {
        APICaller.shared.fetchDesserts { [weak self] result in
            switch result {
            case.success(let meals):
                self?.viewModels = meals.compactMap({
                    FRDessertCellViewModel(
                        meals: $0
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
    
    private func searchedDesserts(search:String) {
        APICaller.shared.searchedDesserts(with: search) { [weak self] result in
            switch result {
            case.success(let meals):
                self?.isFiltered = true
                self?.filteredViewModels = meals.compactMap({
                    FRDessertCellViewModel(meals: $0)
                })
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                    self?.searchVC.dismiss(animated: true, completion: nil)
                }
            case .failure( _ ):
                fatalError()
            }
        }
    }
}


