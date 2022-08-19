//
//  Dish.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 18..
//

import Foundation

struct Dish {
    let id, name, description, image: String?
    let calories: Int?
    
    var formattedCalories: String {
        return "\(calories ?? 0) calories"
    }
}
