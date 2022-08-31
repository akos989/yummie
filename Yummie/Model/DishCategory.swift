//
//  DishCategory.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 17..
//

import Foundation

struct DishCategory: Codable {
    let id, title, image: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title // = "name" -> should be used if the backend response has different key names (here: name is in the backend)
        case image
    }
}
