//
//  HomeViewController.swift
//  Yummie
//
//  Created by Ákos Morvai on 2022. 08. 17..
//

import UIKit
	
class HomeViewController: UIViewController {
    @IBOutlet var categoryCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    @IBOutlet var specialsCollectionView: UICollectionView!
    
    var categories: [DishCategory] = [
        .init(id: "id1", name: "African Dish 1", image: "https://picsum.photos/100/200"),
        .init(id: "id2", name: "African Dish 2", image: "https://picsum.photos/100/200"),
        .init(id: "id3", name: "African Dish 3", image: "https://picsum.photos/100/200"),
        .init(id: "id4", name: "African Dish 4", image: "https://picsum.photos/100/200"),
        .init(id: "id5", name: "African Dish 5", image: "https://picsum.photos/100/200")
    ]
    
    var popularDishes: [Dish] = [
        .init(id: "id1", name: "Garri", description: "This is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food everThis is the best food ever", image: "https://picsum.photos/100/200", calories: 34),
        .init(id: "id2", name: "Pizza", description: "This is the best food ever", image: "https://picsum.photos/100/200", calories: 314),
        .init(id: "id3", name: "Lasagne", description: "This is the best food ever", image: "https://picsum.photos/100/200", calories: 134),
        .init(id: "id4", name: "Cucumber", description: "This is the best food ever", image: "https://picsum.photos/100/200", calories: 4),
        .init(id: "id5", name: "Rice", description: "This is the best food ever", image: "https://picsum.photos/100/200", calories: 56)
    ]
    
    var specialDishes: [Dish] = [
        .init(id: "id1", name: "Kefta", description: "Very good Moroccan meal", image: "https://picsum.photos/100/200", calories: 98),
        .init(id: "id2", name: "Curry", description: "Traditional food in India", image: "https://picsum.photos/100/200", calories: 120)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                return
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
