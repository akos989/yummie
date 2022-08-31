//
//  AllDishes.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 25..
//

import Foundation

struct AllDishes: Codable {
    let categories: [DishCategory]?
    let populars: [Dish]?
    let specials: [Dish]?
}
