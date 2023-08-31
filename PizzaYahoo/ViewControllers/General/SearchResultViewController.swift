//
//  SearchResultViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 31.08.2023.
//

import UIKit

protocol SearchResultVCDelegate: AnyObject {
    func didTappedItem(_ dish: Dish)
}

final class SearchResultViewController: UIViewController {
    
    weak var delegate: SearchResultVCDelegate?
    
    private var dishes: [Dish] = []
    
    private let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(
            width: UIScreen.main.bounds.width / 3 - 10,
            height: 150
        
        )
        flowLayout.minimumInteritemSpacing = 3
        flowLayout.minimumLineSpacing = 3
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(
            DishCollectionViewCell.self,
            forCellWithReuseIdentifier: DishCollectionViewCell.identifier
        )
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
       
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.frame = view.bounds
    }
    
    func configure(with newDishes: [Dish]) {
        dishes = newDishes
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}

extension SearchResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DishCollectionViewCell.identifier, for: indexPath)
        
        guard let cell = cell as? DishCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let dish = dishes[indexPath.item]

        cell.configure(with: dish)
        return cell
    }
}

extension SearchResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dish = dishes[indexPath.item]
        delegate?.didTappedItem(dish)

    }
}
