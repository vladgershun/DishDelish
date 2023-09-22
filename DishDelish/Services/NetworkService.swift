//
//  NetworkService.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

enum ErrorType: LocalizedError {
    case badURL
    case notDecodable
    
    var errorDescription: String? {
        switch self {
        case .badURL: return "Bad URL"
        case .notDecodable: return "Bad Data"
        }
    }
}

protocol NetworkService {
    func getData<T: Decodable>(url urlString: String) async throws -> T
}

struct MealNetworkService: NetworkService {
    
    func getData<T: Decodable>(url urlString: String) async throws -> T {
        
        guard let url = URL(string: urlString) else {
            throw ErrorType.badURL
            
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
            return decodedResponse
        } catch {
            throw ErrorType.notDecodable
        }
    }
}
