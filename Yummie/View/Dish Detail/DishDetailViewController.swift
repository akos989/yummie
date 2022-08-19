//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 19..
//

import UIKit

class DishDetailViewController: UIViewController {
    @IBOutlet var dishImageView: UIImageView!
    @IBOutlet var dishTitleLabel: UILabel!
    @IBOutlet var dishCaloriesLabel: UILabel!
    @IBOutlet var dishDescriptionLabel: UILabel!
    @IBOutlet var orderNameTextField: UITextField!
    
    private var dish: Dish?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populateView()
    }
    
    private func populateView() {
        if let dish = dish {
            dishImageView.kf.setImage(with: dish.image?.asUrl)
            dishTitleLabel.text = dish.name
            dishCaloriesLabel.text = dish.formattedCalories
            dishDescriptionLabel.text = dish.description
        }
    }

    func setup(with dish: Dish) {
        self.dish = dish
    }
    
    @IBAction func orderButtonTapped(_ sender: UIButton) {
    }
}
