//
//  NetworkService.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

protocol NetworkService {
    func getData<T: Decodable>(url urlString: String) async throws -> T
}

struct Meals: Codable  {
    var meals: [Meal]
}

struct Meal: Identifiable, Codable {
    var strMeal: String
    var strMealThumb: String
    var idMeal: String
    var id: String { return idMeal }
}



struct MealNetworkService: NetworkService {
    
    func getData<T: Decodable>(url urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            fatalError()
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            print("add error here")
            fatalError()
        }
    }
}


