//
//  CategoryCollectionViewCell.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 17..
//

import UIKit
import Kingfisher

class CategoryCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: CategoryCollectionViewCell.self)
    
    @IBOutlet var categoryImageView: UIImageView!
    @IBOutlet var categoryTitleLabel: UILabel!
    
    func setup(category: DishCategory) {
        categoryTitleLabel.text = category.title
        categoryImageView.kf.setImage(with: category.image?.asUrl)
    }
}
