//
//  ListDishesTableViewController.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 22..
//

import ProgressHUD
import UIKit

class ListDishesTableViewController: UITableViewController {

    var dishes = [Dish]()
    var category: DishCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        registerCells()
        if let category = category,
           let categoryId = category.id {
            title = category.title
            ProgressHUD.show()
            NetworkService.shared.fetchCategoryDishes(categoryId: categoryId) { [weak self] result in
                switch result {
                    case .success(let dishes):
                        ProgressHUD.dismiss()
                        self?.dishes = dishes
                        self?.tableView.reloadData()
                    case .failure(let error):
                        ProgressHUD.showError(error.localizedDescription)
                }
            }
        }
    }
    
    func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dishes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dishListCell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else { fatalError("Could not dequeue \(DishListTableViewCell.identifier)") }
        dishListCell.setup(with: dishes[indexPath.row])
        return dishListCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dishDetailViewController = DishDetailViewController.instantiate()
        dishDetailViewController.setup(with: dishes[indexPath.row])
        navigationController?.pushViewController(dishDetailViewController, animated: true)
    }
}
