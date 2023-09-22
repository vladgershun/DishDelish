//
//  MealVM.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

@MainActor
class MealVM: ObservableObject {
    
    enum State {
        case loading
        case success([Meal])
        case failed
    }
    
    private var networkService: any NetworkService
    
    @Published private(set) var state: State = .loading
    
    init(networkService: any NetworkService) {
        self.networkService = networkService
    }
    
    func getMeals() async {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        do {
            let allMeals: Meals = try await networkService.getData(url: urlString)
            let sorted = allMeals.meals.sorted { $0.title < $1.title }
            self.state = .success(sorted)
        } catch {
            self.state = .failed
        }
    }
}
