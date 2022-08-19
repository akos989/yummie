//
//  DishPortraitCollectionViewCell.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 18..
//

import UIKit

class DishPortraitCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: DishPortraitCollectionViewCell.self)
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var caloriesLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    
    func setup(dish: Dish) {
        titleLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
    }
}
