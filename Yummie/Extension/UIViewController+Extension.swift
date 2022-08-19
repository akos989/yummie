//
//  UIViewController+Extension.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 19..
//

import UIKit

extension UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let name = "name"
        guard let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as? Self else { fatalError("Could not instantiate view controller with storyboard ID: \(identifier)") }
        return viewController
    }
}
