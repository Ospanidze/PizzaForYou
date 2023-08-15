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
        setupRefreshControl()
        
        basketTableView.register(
            BasketViewCell.self,
            forCellReuseIdentifier: idBasketCell
        )
    
        NotificationCenter.default.addObserver(self, selector: #selector(didReceiveSelectedDish(_:)), name: NSNotification.Name("SelectedDishNotification"), object: nil)
    }
    
    //MARK: Private Methods
    private func setupViews() {
        view.addSubview(basketTableView)
        view.addSubview(payButton)
    }
    
    private func setupDelegates() {
        basketTableView.dataSource = self
    }
    
    private func updateTotalSum() {
        let totalSum = cartItems.reduce(0) { $0 + ($1.dish.price * $1.quantity) }
        payButton.setTitle("Оплатить \(totalSum)tg", for: .normal)
    }
    
    @objc private func didReceiveSelectedDish(_ notification: Notification) {
        if let selectedDish = notification.userInfo?["selectedDish"] as? Dish {
    
            if !dishes.contains(where: { $0.id == selectedDish.id }) {
                dishes.append(selectedDish)
                cartItems = dishes.map { CartItem(dish: $0, quantity: 1) }
                updateTotalSum()
                basketTableView.reloadData()
            }
        }
    }
}

//MARK: TableViewDataSource
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
}

//MARK: SetupRefreshControl
private extension BasketViewController {
    func setupRefreshControl() {
        basketTableView.refreshControl = UIRefreshControl()
        basketTableView.refreshControl?.attributedTitle = NSAttributedString(
            string: "Pull to refresh"
        )
        let refreshAction = UIAction { [unowned self] _ in
            reloadBasketTableView()
        }
        basketTableView.refreshControl?.addAction(refreshAction, for: .valueChanged)
    }
    
    func reloadBasketTableView() {
        basketTableView.reloadData()
        if basketTableView.refreshControl != nil {
            basketTableView.refreshControl?.endRefreshing()
        }
    }
}

//MARK: SetupLayout
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
