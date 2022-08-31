//
//  Order.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 22..
//

import Foundation

struct Order: Codable {
    let id, name: String?
    let dish: Dish?
}
