//
//  OnboardingCollectionViewCell.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 16..
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = String(describing: OnboardingCollectionViewCell.self)
    
    @IBOutlet var slideImageView: UIImageView!
    @IBOutlet var slideTitleLabel: UILabel!
    @IBOutlet var slideDescriptionLabel: UILabel!
    
    func setup(_ slide: OnboardingSlide) {
        slideImageView.image = slide.image
        slideTitleLabel.text = slide.title
        slideDescriptionLabel.text = slide.description
    }
}
