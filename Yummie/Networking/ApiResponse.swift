//
//  ApiResponse.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 25..
//

import Foundation

struct ApiResponse<T: Decodable>: Decodable {
    let status: Int
    let message: String?
    let data: T?
    let error: String?
}
