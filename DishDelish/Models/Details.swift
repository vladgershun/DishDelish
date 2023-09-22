//
//  Details.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/20/23.
//

import Foundation

struct Details: Decodable {
    var meals: [Recipe]
}

struct Recipe: Identifiable, Codable {
    
    var id: String
    var title: String
    var thumbnail: String
    var instructions: String
    var ingredients: [Ingredient]
    
    struct Ingredient: Codable {
        public var ingredient: String
        public var measurement: String
    }
    
    struct StringCodingKey: CodingKey {
        var stringValue: String
        
        init(stringValue: String) {
            self.stringValue = stringValue
        }
        
        init?(intValue: Int) {
            return nil
        }
        
        var intValue: Int? {
            return nil
        }
    }
    
    init(from decoder: Decoder) throws {
        ingredients = []
        let mealsContainer = try decoder.container(keyedBy: StringCodingKey.self)
        self.id = try mealsContainer.decode(String.self, forKey: StringCodingKey(stringValue: "idMeal"))
        self.title = try mealsContainer.decode(String.self, forKey: StringCodingKey(stringValue: "strMeal"))
        self.thumbnail = try mealsContainer.decode(String.self, forKey: StringCodingKey(stringValue: "strMealThumb"))
        self.instructions = try mealsContainer.decode(String.self, forKey: StringCodingKey(stringValue: "strInstructions"))
        for i in 1...20 {
            if let tempIngredient = try? mealsContainer.decodeIfPresent(String.self, forKey: StringCodingKey(stringValue: "strIngredient\(i)")),
               let tempMeasurement = try? mealsContainer.decodeIfPresent(String.self, forKey: StringCodingKey(stringValue: "strMeasure\(i)")),
               !tempIngredient.isEmpty,
               !tempMeasurement.isEmpty {
                ingredients.append(Ingredient(ingredient: tempIngredient, measurement: tempMeasurement))
            }
        }
    }
}
