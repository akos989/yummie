//
//  UIImage+Extension.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 16..
//

import UIKit

extension UIImage {
    convenience init?(uncached name: String) {
        if let path = Bundle.main.path(forResource: name, ofType: "png") {
            self.init(contentsOfFile: path)
        } else {
            return nil
        }
    }

}
