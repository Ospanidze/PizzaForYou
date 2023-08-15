//
//  Classification.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import Foundation

struct Classification: Decodable {
    let сategories: [Сategory]
}

struct Сategory: Decodable {
    let name: String
    let imageURL: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case imageURL = "image_url"
    }
}
