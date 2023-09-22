//
//  Extensions.swift
//  DishDelish
//
//  Created by Vlad Gershun on 9/21/23.
//

import Foundation

extension Set: RawRepresentable where Element: Hashable & Codable {
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
            let results = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = Set(results)
    }

    public var rawValue: String {
        do {
            let data = try JSONEncoder().encode(Array(self))
            return String(data: data, encoding: .utf8) ?? ""
        } catch {
            return ""
        }
    }
}
