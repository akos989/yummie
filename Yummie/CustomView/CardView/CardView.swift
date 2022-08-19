//
//  CardView.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 17..
//

import UIKit

class CardView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialSetup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        initialSetup()
    }
    
    func initialSetup() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = .zero
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
        
        cornerRadius = 10
    }
}
