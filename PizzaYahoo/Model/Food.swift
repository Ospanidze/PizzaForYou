//
//  Category.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import Foundation

// MARK: - Category
struct Food: Decodable {
    let dishes: [Dish]
}

// MARK: - Dish
struct Dish: Decodable {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: String
    let tegs: [Teg]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

enum Teg: String, CaseIterable, Decodable {
    case всеМеню = "Все меню"
    case сРисом = "С рисом"
    case сРыбой = "С рыбой"
    case салаты = "Салаты"
}
