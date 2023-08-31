//
//  ResearchViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

final class ResearchViewController: UIViewController {
    
    private var dishes: [Dish] = []
    private let networkManager = NetworkManager.shared
    
    private let leftView = LeftNavBarView()
    
    private let searchTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(
            UITableViewCell.self,
            forCellReuseIdentifier: "UITableViewCell.self"
        )
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let contoller = UISearchController(searchResultsController: SearchResultViewController())
        contoller.searchBar.placeholder = "Search foods"
        contoller.searchBar.searchBarStyle  = .minimal
        return contoller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Search"
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .label
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.searchController = searchController
        
        view.addSubview(searchTableView)
        searchTableView.frame = view.bounds
        
        searchTableView.rowHeight = 100
        setupNavigationBar(leftView)
        delegates()
        fetchDishes()
    }
    
    private func delegates() {
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchController.searchResultsUpdater = self
    }
    
    private func fetchDishes() {
        networkManager.fetch(Food.self, from: Link.food.url) { result in
            switch result {
            case .success(let food):
                self.dishes = food.dishes
                DispatchQueue.main.async { [weak self] in
                    self?.searchTableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func selectedDish(_ dish: Dish) {
        let descriptionVC = DescriptionViewController()
        descriptionVC.configure(with: dish)
        navigationController?.pushViewController(descriptionVC, animated: true)
    }
    
}


extension ResearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dishes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell.self", for: indexPath)
        cell.selectionStyle = .none
        let dish = dishes[indexPath.row]
        
//        networkManager.fetchImage(from: dish.imageURL) { [weak cell] result in
//            guard let cell = cell else { return }
//                switch result {
//                case .success(let imageData):
//                    var content = cell.defaultContentConfiguration()
//
//                    content.image = UIImage(data: imageData)
//                    content.imageProperties.cornerRadius = tableView.rowHeight / 2
//                    content.imageProperties.maximumSize = CGSize(width: Double(tableView.rowHeight), height: Double(tableView.rowHeight))
//                    content.textProperties.font = UIFont.systemFont(ofSize: 18)
//                    content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14)
//                    content.secondaryTextProperties.color = .systemGray3
//                    content.text = dish.name
//                    content.secondaryText = "price:\(dish.price) weight:\(dish.weight)"
//                    cell.contentConfiguration = content
//
//                case .failure(let error):
//                    print(error.localizedDescription)
//                }
//        }
        var content = cell.defaultContentConfiguration()
    
        content.image = UIImage(named: "basket")
        content.imageProperties.cornerRadius = tableView.rowHeight / 2
        //content.imageProperties.maximumSize = CGSize(width: Double(tableView.rowHeight), height: Double(tableView.rowHeight))
        content.textProperties.font = UIFont.systemFont(ofSize: 18)
        content.secondaryTextProperties.font = UIFont.systemFont(ofSize: 14)
        content.secondaryTextProperties.color = .systemGray3
        content.text = dish.name
        content.secondaryText = "price:\(dish.price) weight:\(dish.weight)"
        cell.contentConfiguration = content
        
        
        return cell
    }
}

extension ResearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let dish = dishes[indexPath.row]
        selectedDish(dish)
    }
}

extension ResearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        guard let query = searchBar.text,
              !query.trimmingCharacters(in: .whitespaces).isEmpty,
              query.trimmingCharacters(in: .whitespaces).count > 2,
              let resultController = searchController.searchResultsController as?
                SearchResultViewController else { return }
        
        let newDishes = dishes.filter { dish in
            dish.description.contains(query.lowercased())
        }
        
        print(query)
        resultController.delegate = self
        resultController.configure(with: newDishes)
    }
}

extension ResearchViewController: SearchResultVCDelegate {
    func didTappedItem(_ dish: Dish) {
        selectedDish(dish)
    }
}
