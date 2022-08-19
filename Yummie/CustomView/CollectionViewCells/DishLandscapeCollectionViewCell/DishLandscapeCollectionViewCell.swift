//
//  DishLandscapeCollectionViewCell.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 18..
//

import UIKit

class DishLandscapeCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: DishLandscapeCollectionViewCell.self)
    
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var caloriesLabel: UILabel!
    
    func setup(dish: Dish) {
        titleLabel.text = dish.name
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        caloriesLabel.text = dish.formattedCalories
        descriptionLabel.text = dish.description
    }
}
