//
//  HomeViewController.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 17..
//

import ProgressHUD
import UIKit
	
class HomeViewController: UIViewController {
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var specialsCollectionView: UICollectionView!
    
    var categories = [DishCategory]()
    var popularDishes = [Dish]()
    var specialDishes = [Dish]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ProgressHUD.show()
        
        Task {
            do {
                let allDishes = try await NetworkService.shared.fetchAllCategories()
                categories = allDishes.categories ?? []
                popularDishes = allDishes.populars ?? []
                specialDishes = allDishes.specials ?? []
                ProgressHUD.dismiss()
            } catch {
                ProgressHUD.showError(error.localizedDescription)
            }
        }
        
        specialsCollectionView.delegate = self
        specialsCollectionView.dataSource = self
        
        registerCells()
    }
    
    private func registerCells() {
        categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.identifier)
        
        popularCollectionView.register(UINib(nibName: DishPortraitCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishPortraitCollectionViewCell.identifier)
        
        specialsCollectionView.register(UINib(nibName: DishLandscapeCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: DishLandscapeCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
            case categoryCollectionView:
                return categories.count
            case popularCollectionView:
                return popularDishes.count
            case specialsCollectionView:
                return specialDishes.count
            default:
                return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
            case categoryCollectionView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.identifier, for: indexPath) as? CategoryCollectionViewCell else { fatalError("Could not dequeue \(CategoryCollectionViewCell.identifier) cell") }
                cell.setup(category: categories[indexPath.item])
                return cell
            case popularCollectionView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishPortraitCollectionViewCell.identifier, for: indexPath) as? DishPortraitCollectionViewCell else { fatalError("Could not dequeue \(DishPortraitCollectionViewCell.identifier) cell") }
                cell.setup(dish: popularDishes[indexPath.item])
                return cell
            case specialsCollectionView:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishLandscapeCollectionViewCell.identifier, for: indexPath) as? DishLandscapeCollectionViewCell else { fatalError("Could not dequeue \(DishLandscapeCollectionViewCell.identifier) cell") }
                cell.setup(dish: specialDishes[indexPath.item])
                return cell
            default:
                return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch collectionView {
            case categoryCollectionView:
                let controller = ListDishesTableViewController.instantiate()
                controller.category = categories[indexPath.item]
                navigationController?.pushViewController(controller, animated: true)
            case popularCollectionView:
                displayDishDetails(of: popularDishes[indexPath.item])
            case specialsCollectionView:
                displayDishDetails(of: specialDishes[indexPath.item])
            default:
                return
        }
    }
    
    private func displayDishDetails(of dish: Dish) {
        let dishDetailViewController = DishDetailViewController.instantiate()
        dishDetailViewController.setup(with: dish)
        navigationController?.pushViewController(dishDetailViewController, animated: true)
    }
}
