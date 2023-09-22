//
//  MealsView.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import SwiftUI

struct MealsView: View {
    
    @StateObject private var vm = MealVM(networkService: MealNetworkService())
    
    var body: some View {
        ForEach(vm.meals) { meal in
            Text(meal.strMeal)
        }
        .task {
            vm.getMeals()
        }
    }
}

#Preview {
    MealsView()
}
