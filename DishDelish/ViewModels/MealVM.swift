//
//  MealVM.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

@MainActor
class MealVM: ObservableObject {
    
    private var networkService: any NetworkService
    
    @Published var meals: [Meal] = []
    
    init(networkService: any NetworkService) {
        self.networkService = networkService
    }
    
    func getMeals() {
        let urlString = "https://themealdb.com/api/json/v1/1/filter.php?c=Dessert"
        Task {
            let allMeals: Meals = try await networkService.getData(url: urlString)
            self.meals = allMeals.meals
        }
    }
}
