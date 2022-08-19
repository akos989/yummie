//
//  UIView+Extension.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 16..
//

import Foundation
import UIKit

extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        get { return self.cornerRadius }
        set {
            self.layer.cornerRadius = newValue
        }
    }
}
