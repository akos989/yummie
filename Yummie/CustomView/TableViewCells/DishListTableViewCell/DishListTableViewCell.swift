//
//  DishListTableViewCell.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 22..
//

import UIKit

class DishListTableViewCell: UITableViewCell {
    static let identifier = "DishListTableViewCell"
    
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var dishNameLabel: UILabel!
    @IBOutlet var dishDescriptionLabel: UILabel!
    
    func setup(with dish: Dish) {
        dishImageView.kf.setImage(with: dish.image?.asUrl)
        dishNameLabel.text = dish.name
        dishDescriptionLabel.text = dish.description
    }
    
    func setup(with order: Order) {
        dishImageView.kf.setImage(with: order.dish?.image?.asUrl)
        dishNameLabel.text = order.dish?.name
        dishDescriptionLabel.text = order.name
    }
}
