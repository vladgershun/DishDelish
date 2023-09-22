//
//  DetailView.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import SwiftUI

struct DetailView: View {
    
    @AppStorage("favorites") var favorites = Set<String>()
    @StateObject private var vm = DetailVM(networkService: MealNetworkService())
    var mealID: String
    @State var task: Task<Void, Never>?

    var body: some View {
        Group {
            switch vm.state {
            case .success(let recipe):
                List(recipe) { recipe in
                    Section {
                        AsyncImage(url: URL(string: recipe.thumbnail), scale: 2) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .clipped()
                        } placeholder: {
                            ProgressView()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .aspectRatio(1.0, contentMode: .fit)
                        }
                    }
                    .listRowInsets(EdgeInsets())
                    .navigationTitle(recipe.title)
                    .toolbarTitleDisplayMode(.inline)
                    
                    DisclosureGroup {
                        Text(recipe.instructions)
                    } label: {
                        HStack(spacing: 20) {
                            Image(systemName: "book")
                            Text("Instructions")
                        }
                    }
                    
                    DisclosureGroup {
                        IngredientsView(ingredients: recipe.ingredients)
                    } label: {
                        HStack(spacing: 20) {
                            Image(systemName: "cart")
                            Text("Ingredients")
                        }
                    }
                }
            case .loading: ProgressView()
            case .failed:
                Button("Reload") {
                    task = Task {
                        await vm.getRecipe()
                    }
                }
                .buttonStyle(.borderedProminent)
                .onDisappear {
                    task?.cancel()
                }
            }
        }
        .toolbar {
            Button { 
                if favorites.contains(mealID) {
                    favorites.remove(mealID)
                } else {
                    favorites.insert(mealID)
                }
            } label: {
                if favorites.contains(mealID) {
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                } else {
                    Image(systemName: "heart")
                        .foregroundStyle(.red)
                }
            }
        }
        .task(id: mealID) {
            vm.id = mealID
            await vm.getRecipe()
        }
    }
}

struct IngredientsView: View {
    var ingredients: [Recipe.Ingredient]
    
    var body: some View {
        ForEach(ingredients, id: \.ingredient) { item in
            HStack {
                Text("• \(item.ingredient)")
                Spacer()
                Text(item.measurement)
            }
            .listStyle(.plain)
        }
    }
}
