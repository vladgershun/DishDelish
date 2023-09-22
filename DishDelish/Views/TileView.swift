//
//  TileView.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import SwiftUI

struct TileView: View {
    
    @AppStorage("favorites") var favorites = Set<String>()
    var meal: Meal
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            AsyncImage(url: URL(string: meal.thumbnail), scale: 1) { image in
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
            
            if favorites.contains(meal.id) {
                Image(systemName: "heart.fill")
                      .foregroundStyle(.red)
                      .font(.largeTitle)
                      .padding(5)
            }
            
        }
        .overlay (title, alignment: .bottom)
        .cornerRadius(10)
        .overlay {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.secondary, lineWidth: 3)
        }
    }
    
    private var title: some View {
        Text(meal.title)
            .frame(maxWidth: .infinity)
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.black.opacity(0.7))
    }
}
