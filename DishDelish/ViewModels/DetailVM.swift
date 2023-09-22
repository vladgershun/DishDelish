//
//  DetailVM.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

@MainActor
class DetailVM: ObservableObject {
    
    enum State {
        case loading
        case success(data: [Recipe])
        case failed
    }
    
    private var networkService: any NetworkService
    
    var id = ""
    
    @Published private(set) var state: State = .loading
    
    init(networkService: any NetworkService) {
        self.networkService = networkService
    }
    
    func getRecipe() async {
        let urlString = "https://themealdb.com/api/json/v1/1/lookup.php?i=\(id)"
        do {
            let recipe: Details = try await networkService.getData(url: urlString)
            self.state = .success(data: recipe.meals)
        } catch {
            self.state = .failed
        }
    }
}
