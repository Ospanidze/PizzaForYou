//
//  BasketViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

struct CartItem {
    let dish: Dish
    var quantity: Int
}

final class BasketViewController: UIViewController {
    private let customAlert = CustomAlert()
    
    private let networkManager = NetworkManager.shared
    
    private let idBasketCell = "idBasketCell"
    
    private var dishes: [Dish] = []
    private var sortedDishes: [Dish] = []
    private var cartItems: [CartItem] = []
    
    private let leftView = LeftNavBarView()
    //private let customAlert = CustomAlert()
    
    private let basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Оплатить 0tg", for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
        setupLayout()
        setupNavigationBar(leftView)
        setupDelegates()
        
        basketTableView.register(
            BasketViewCell.self,
            forCellReuseIdentifier: idBasketCell
        )
        //fetchDishes()
        
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSelectedDish(_:)), name: NSNotification.Name("SelectedDishNotification"), object: nil)

    }
    
//    func addSelectedDishToBasket(_ dish: Dish) {
//        dishes.append(dish)
//        basketTableView.reloadData()
//    }
    
    private func setupViews() {
        view.addSubview(basketTableView)
        view.addSubview(payButton)
    }
    
    private func setupDelegates() {
        basketTableView.dataSource = self
        customAlert.customAlertDelegate = self
    }
    
    @objc func didReceiveSelectedDish(_ notification: Notification) {
        if let selectedDish = notification.userInfo?["selectedDish"] as? Dish {
    
            dishes.append(selectedDish)
            //sortedDishes = dishes.filter { $0.id }
            
            print(sortedDishes)
            cartItems = dishes.map { CartItem(dish: $0, quantity: 1) }
            updateTotalSum()
            basketTableView.reloadData()
        }
    }
    

}


extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dish = dishes[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: idBasketCell, for: indexPath)
        guard let cell = cell as? BasketViewCell else { return UITableViewCell() }
        
        cell.quantityChanged = { [weak self, indexPath] newQuantity in
            self?.cartItems[indexPath.row].quantity = newQuantity
            self?.updateTotalSum()
        }
        cell.setupCell(dish: dish)
        return cell
    }
    
    private func updateTotalSum() {
        let totalSum = cartItems.reduce(0) { $0 + ($1.dish.price * $1.quantity) }
        payButton.setTitle("Оплатить \(totalSum)tg", for: .normal)
    }
}

extension BasketViewController: CustomAlertDelegate {
    func addDish(_ dish: Dish) {
        print(dish)
    }
}

//extension BasketViewController {
//    func fetchDishes() {
//        networkManager.fetch(Food.self, from: Link.food.url) { [unowned self] result in
//            switch result {
//            case .success(let food):
//                dishes = Array(food.dishes[0...2])
//                cartItems = dishes.map { CartItem(dish: $0, quantity: 1) }
//                DispatchQueue.main.async { [weak self] in
//                    self?.updateTotalSum()
//                    self?.basketTableView.reloadData()
//                }
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//    }
//}

//extension BasketViewController: DishViewControllerDelegate {
//    func transfer(_ dish: Dish) {
//        print(dish)
//        dishes.append(dish)
//        DispatchQueue.main.async { [weak self] in
//            self?.basketTableView.reloadData()
//        }
//    }
//}

extension BasketViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            payButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            payButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            payButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            payButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            basketTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            basketTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            basketTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            basketTableView.bottomAnchor.constraint(equalTo: payButton.topAnchor, constant: -10),
        ])
    }
}
