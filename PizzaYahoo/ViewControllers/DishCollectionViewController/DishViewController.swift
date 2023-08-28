//
//  TestCollectionViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 12.08.2023.
//

import UIKit

final class DishViewController: UIViewController {
    
    var dishTitle: String?

    private let networkManager = NetworkManager.shared
    private var groupNames = Teg.allCases
    
    private let groupCollectionView = GroupCollectionView()
    private let dishCollectionView = DishCollectionView()
    
    private let customAlert = CustomAlert()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = dishTitle
        view.backgroundColor = .white
        
        setupDelegates()
        setupViews()
        setupLayout()
        fecthFood()
        
    }
    
    //MARK: Private Methods
    private func setupDelegates() {
        groupCollectionView.groupDelegate = self
        dishCollectionView.dishDelegate = self
    }
    
    private func setupViews() {
        view.addSubview(groupCollectionView)
        view.addSubview(dishCollectionView)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            groupCollectionView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            groupCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor,
                constant: 8
            ),
            groupCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor,
                constant: -8
            ),
            groupCollectionView.heightAnchor.constraint(equalToConstant: 80),
        ])
        
        NSLayoutConstraint.activate([
            dishCollectionView.topAnchor.constraint(
                equalTo: groupCollectionView.bottomAnchor
            ),
            dishCollectionView.leadingAnchor.constraint(
                equalTo: view.leadingAnchor
            ),
            dishCollectionView.trailingAnchor.constraint(
                equalTo: view.trailingAnchor
            ),
            dishCollectionView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            ),
        ])
    }
    
}

//MARK: GroupCollectionViewDelegate
extension DishViewController: GroupCollectionViewDelegate {
    func didSelectGroup(at group: Teg) {
        dishCollectionView.updateDishesForGroup(at: group)
    }
}

extension DishViewController: DishCollectionViewDelegate {
    func didSelectDish(at dish: Dish) {
        customAlert.presentCustomAlert(viewController: self, dish: dish)
    }
}

//MARK: FetchFood
extension DishViewController {
    private func fecthFood() {
        networkManager.fetch(Food.self, from: Link.food.url) {[weak self] result in
            switch result {
            case .success(let food):
//                self?.dishes = food.dishes
                DispatchQueue.main.async {
                    self?.dishCollectionView.setupCollectionView(dishes: food.dishes)
                    self?.groupCollectionView.setupGroupCollectionView(groupNames: self?.groupNames ?? [])
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
