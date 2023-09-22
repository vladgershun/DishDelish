//
//  Meals.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

struct Meals: Codable  {
    var meals: [Meal]
}

struct Meal: Identifiable, Codable {
    
    enum CodingKeys: String, CodingKey {
        case id = "idMeal"
        case title = "strMeal"
        case thumbnail = "strMealThumb"
    }
    
    var id: String
    var title: String
    var thumbnail: String
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
}
