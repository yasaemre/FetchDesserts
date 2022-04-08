//
//  APICaller.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    let baseURL         = "https://www.themealdb.com"
    
    private init() {}
    
    public func fetchDesserts(completed: @escaping (Result<[Meals], FRError>) -> Void) {
        let endpoint = baseURL + "/api/json/v1/1/filter.php?c=Dessert"
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidUrl))
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(APIResponse.self, from: data)
                print("Desserts: \(result.meals.count)")
                completed(.success(result.meals))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }


}
