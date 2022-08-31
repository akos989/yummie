//
//  DishDetailViewController.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 19..
//

import ProgressHUD
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
        guard let name = orderNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              !name.isEmpty else {
                  ProgressHUD.showError("Please enter your name")
                  return
              }
        if let dish = dish,
           let dishId = dish.id {
            ProgressHUD.show("Placing Order...")
            NetworkService.shared.placeOrder(dishId: dishId, name: name) { result in
                switch result {
                    case .success(_):
                        ProgressHUD.showSuccess("Your order has been received.")
                    case .failure(let error):
                        ProgressHUD.showError(error.localizedDescription)
                }
            }
        } else {
            ProgressHUD.showError("Something went wrong")
        }
    }
}
