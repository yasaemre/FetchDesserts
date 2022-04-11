//
//  APICaller.swift
//  FetchRewardsIOSChallange
//
//  Created by Emre Yasa on 4/8/22.
//

import Foundation

final class APICaller {
    static let shared = APICaller()
    
    let baseURL = "https://www.themealdb.com"
    
    private init() {}
    
    public func fetchDesserts(completed: @escaping (Result<[Desserts], FRError>) -> Void) {
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
                completed(.success(result.meals))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    public func searchedDesserts(with query:String, completed: @escaping (Result<[Desserts], FRError>) -> Void) {
        let endpoint = baseURL + "/api/json/v1/1/search.php?s="
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        let urlString = endpoint + query
        guard let url = URL(string: urlString)  else {
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
                completed(.success(result.meals))
            } catch {
                completed(.failure(.invalidData))
            }
            
        }
        
        task.resume()
    }
    
    func fetchDessert(for id: Int, completed: @escaping (Result<[DessertsById], FRError>) -> Void) {
        let endpoint = baseURL + "/api/json/v1/1/lookup.php?i=\(id)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(.invalidUrl))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let _ = error {
                completed(.failure(.unableToComplete))
                return
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
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dessert = try decoder.decode(APIResponseForDessert.self, from: data)
                completed(.success(dessert.meals))
            } catch {
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
