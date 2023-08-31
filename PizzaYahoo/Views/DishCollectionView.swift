//
//  DishCollectionView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

protocol DishCollectionViewDelegate: AnyObject {
    func didSelectDish(at dish: Dish)
}

final class DishCollectionView: UICollectionView {
    
    weak var dishDelegate: DishCollectionViewDelegate?
    
    private let idDish = "idDish"
    private var allDishes: [Dish] = []
    private var displayedDishes: [Dish] = []
    
    private let collectionFlowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionFlowLayout)
        
        register(DishCollectionViewCell.self, forCellWithReuseIdentifier: idDish)
        
        setupConfigure()
        setupCollectionLayout()
        setupDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCollectionView(dishes: [Dish]) {
        allDishes = dishes
        displayedDishes = allDishes
        reloadData()
    }
    
    func updateDishesForGroup(at group: Teg) {
        displayedDishes = allDishes.filter { $0.tegs.contains(group) }
        reloadData()
    }
    
    private func setupConfigure() {
        translatesAutoresizingMaskIntoConstraints = false
        //backgroundColor = .yellow
    }
    
    private func setupCollectionLayout() {
        collectionFlowLayout.minimumInteritemSpacing = 2
        collectionFlowLayout.minimumLineSpacing = 5
        collectionFlowLayout.scrollDirection = .vertical
        collectionFlowLayout
            .collectionView?
            .showsVerticalScrollIndicator = false
    }
    
    private func setupDelegate() {
        dataSource = self
        delegate = self
    }
}

//MARK: UI
extension DishCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let dishSelected = displayedDishes[indexPath.item]
        dishDelegate?.didSelectDish(at: dishSelected)
    }
}

//MARK: UICollectionViewDataSource

extension DishCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        displayedDishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let dish = displayedDishes[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: idDish,
            for: indexPath
        )
        
        guard let dishCell = cell as? DishCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        dishCell.configure(with: dish)
        return dishCell
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension DishCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = collectionViewWidth / 3 - 10
        return CGSize(width: cellWidth, height: cellWidth + 20)
    }
}
