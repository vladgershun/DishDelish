//
//  MealsView.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import SwiftUI

struct MealsView: View {
    
    @StateObject private var vm = MealVM(networkService: MealNetworkService())
    @AppStorage("favorites") var favorites = Set<String>()
    @State var searchText = ""
    @State var task: Task<Void, Never>?
    
    var body: some View {
        VStack {
            switch vm.state {
            case .success(let data):
                NavigationView {
                    ScrollView {
                        MyGridView(searchText: searchText, meals: data)
                    }
                    .navigationTitle("Meals")
                    .toolbar {
                        Button("Clear Favorites") {
                            favorites.removeAll()
                        }
                        .disabled(favorites.isEmpty)
                    }
                }
                
            case .loading: ProgressView()
            case .failed:
                Button("Reload") {
                    task = Task {
                        await vm.getMeals()
                    }
                }
                .buttonStyle(.borderedProminent)
                .onDisappear {
                    task?.cancel()
                }
            }
        }
        .searchable(text: $searchText)
        .task {
            await vm.getMeals()
        }
        
    }
}

struct MyGridView: View {
    
    private let layout = [GridItem(.flexible()),GridItem(.flexible())]
    var searchText: String
    var meals: [Meal]
    
    var body: some View {
        LazyVGrid(columns: layout) {
            ForEach(searchedMeals) { meal in
                NavigationLink {
                    DetailView(mealID: meal.id)
                } label: {
                    TileView(meal: meal)
                }
            }
            .padding(.vertical, 2)
        }
        .padding()
    }
    
    var searchedMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
}



#Preview {
    MealsView()
}



