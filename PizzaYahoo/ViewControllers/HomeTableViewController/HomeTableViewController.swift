//
//  MainViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

final class HomeTableViewController: UITableViewController {
    
    private let idMainTableViewCell = "idMainTableViewCell"
    
    private let networkManager = NetworkManager.shared
    private var categories: [Сategory] = []
    
    private let leftView = LeftNavBarView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        tableView.backgroundView?.backgroundColor = .systemBackground
        tableView.rowHeight = 140
        tableView.register(
            MainTableViewCell.self,
            forCellReuseIdentifier: idMainTableViewCell
        )
        setupNavigationBar(leftView)
        fetchClassification()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let category = categories[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: idMainTableViewCell,
            for: indexPath
        )
        guard let cell = cell as? MainTableViewCell else {
            return UITableViewCell()
        }
        
        cell.setupCell(category: category)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        guard let cell = tableView.cellForRow(at: indexPath) as? MainTableViewCell else {
//            return
//        }
        
        let category = categories[indexPath.row]
        switch indexPath {
        case [0, 2]: pushController(title: category.name)
        default: break
        }
        
    }
    
    private func pushController(title: String) {
        let dishVC = DishViewController()
        dishVC.dishTitle = title
        navigationController?.pushViewController(dishVC, animated: true)
    }
}

extension HomeTableViewController {
    func fetchClassification() {
        networkManager.fetch(Classification.self, from: Link.classification.url) { [weak self] result in
            switch result {
            case .success(let classification):
                self?.categories = classification.сategories
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


//MARK: SetupNavigationBar

extension UIViewController {
    func setupNavigationBar(_ customView: UIView) {
        let leftBarItem = UIBarButtonItem(customView: customView)
        
        let rightBarItem = UIBarButtonItem(
            image: UIImage(named: "girl")?.withRenderingMode(.alwaysOriginal),
            style: .plain,
            target: nil,
            action: nil
        )
        
        navigationItem.leftBarButtonItem = leftBarItem
        navigationItem.rightBarButtonItem = rightBarItem
    }
}
