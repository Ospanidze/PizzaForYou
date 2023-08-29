//
//  BasketViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

protocol BasketViewControllerDelegate: AnyObject {
    func transmit(_ message: String)
}

struct CartItem {
    let dish: Dish
    var quantity = 1
}

final class BasketViewController: UIViewController {
    
    private let idBasketCell = "idBasketCell"
    
    private var cartItems: [CartItem] = []
    
    private let leftView = LeftNavBarView()
    
    private var cartItemsCount: Int = 0 {
        didSet {
            updateCartBadge()
        }
    }
    
    private let basketTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.backgroundView?.backgroundColor = .white
        tableView.rowHeight = 80
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var payButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Оплатить 0tg", for: .normal)
        button.setTitleColor(.brown, for: .highlighted)
        button.titleLabel?.font = UIFont.sfProDisplay(size: 18)
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
        basketTableView.delegate = self
    }
    
    private func updateTotalSum() {
        let totalSum = cartItems.reduce(0) { $0 + $1.dish.price * $1.quantity }
        payButton.setTitle("Оплатить \(totalSum)tg", for: .normal)
    }
    
    @objc private func didReceiveSelectedDish(_ notification: Notification) {
        if let selectedDish = notification.userInfo?["selectedDish"] as? Dish {

            if let index = cartItems.firstIndex(where: { $0.dish.id == selectedDish.id }) {
                cartItems[index].quantity += 1
            } else {
                let cartItem = CartItem(dish: selectedDish)
                cartItems.append(cartItem)
                cartItemsCount = cartItems.count
            }

            updateTotalSum()
            basketTableView.reloadData()
        }
    }
    
    private func updateCartBadge() {
        if let tabBarController = self.tabBarController {
            let cartTabIndex = 2 
            if cartItemsCount > 0 {
                //tabBarController.tabBar.items?[cartTabIndex].badgeColor = .systemGreen
                tabBarController.tabBar.items?[cartTabIndex].badgeValue = "\(cartItemsCount)"
            } else {
                tabBarController.tabBar.items?[cartTabIndex].badgeValue = nil
            }
        }
    }
}

//MARK: TableViewDataSource
extension BasketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        cartItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cartItem = cartItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: idBasketCell, for: indexPath)
        guard let cell = cell as? BasketViewCell else { return UITableViewCell() }
        
        cell.quantityChanged = { [unowned self, indexPath] newQuantity in
            guard newQuantity != 0 else {
                self.cartItems.remove(at: indexPath.row)
                self.cartItemsCount = cartItems.count
                self.updateTotalSum()
                tableView.reloadData()
                return
            }
            
            self.cartItems[indexPath.row].quantity = newQuantity
            self.updateTotalSum()
            
        }
        
        cell.setupCell(cartItem: cartItem)
        
        return cell
    }
}

//MARK: TableViewDelegate
extension BasketViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cartItems.remove(at: indexPath.row)
            cartItemsCount = cartItems.count
            tableView.deleteRows(at: [indexPath], with: .automatic)
            updateTotalSum()
        }
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
