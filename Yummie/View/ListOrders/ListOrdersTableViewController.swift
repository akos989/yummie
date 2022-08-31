//
//  ListOrdersTableViewController.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 22..
//

import ProgressHUD
import UIKit

class ListOrdersTableViewController: UITableViewController {

    var orders = [Order]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"
        registerCells()
        
        ProgressHUD.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        NetworkService.shared.fetchOrders { [weak self] result in
            switch result {
                case .success(let orders):
                    self?.orders = orders
                    self?.tableView.reloadData()
                    ProgressHUD.dismiss()
                case .failure(let error):
                    ProgressHUD.showError(error.localizedDescription)
            }
        }
    }
    
    private func registerCells() {
        tableView.register(UINib(nibName: DishListTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: DishListTableViewCell.identifier)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        orders.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let dishListCell = tableView.dequeueReusableCell(withIdentifier: DishListTableViewCell.identifier, for: indexPath) as? DishListTableViewCell else { fatalError("Could not dequeue cell") }
        dishListCell.setup(with: orders[indexPath.row])
        return dishListCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dishDetailViewController = DishDetailViewController.instantiate()
        if let dish = orders[indexPath.row].dish {
            dishDetailViewController.setup(with: dish)
        }
        navigationController?.pushViewController(dishDetailViewController, animated: true)
    }
}
