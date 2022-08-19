//
//  String+Extension.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 17..
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
