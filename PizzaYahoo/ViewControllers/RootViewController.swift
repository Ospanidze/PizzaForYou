//
//  ViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

enum Tab: String {
    case main = "Главная"
    case research = "Поиск"
    case basket = "Корзина"
    case account = "Аккаунт"
    
    var image: String {
        switch self {
        case .main:
            return "house"
        case .research:
            return "magnifyingglass"
        case .basket:
            return "cart"
        case .account:
            return "person.circle"
        }
    }
}

final class RootViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        setupTabBar()
    }
    
    private func configure() {
        tabBar.backgroundColor = .white
        //tabBar.tintColor = .black
        //tabBar.unselectedItemTintColor = .systemBlue
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }
    
    private func setupTabBar() {
        let mainNavigationVC = createNavigationVC(
            vc: HomeTableViewController(),
            title: Tab.main.rawValue,
            imageTitle: Tab.main.image
        )
        let researchNavigationVC = createNavigationVC(
            vc: ResearchViewController(),
            title: Tab.research.rawValue,
            imageTitle: Tab.research.image
        )
        let basketNavigationVC = createNavigationVC(
            vc: BasketViewController(),
            title: Tab.basket.rawValue,
            imageTitle: Tab.basket.image
        )
        let accountNavigationVC = createNavigationVC(
            vc: AccountViewController(),
            title: Tab.account.rawValue,
            imageTitle: Tab.account.image
        )
        
        viewControllers = [
            mainNavigationVC,
            researchNavigationVC,
            basketNavigationVC,
            accountNavigationVC
        ]
    }
    
    private func createNavigationVC(vc: UIViewController, title: String, imageTitle: String) -> UINavigationController {
        let tabBarItem = UITabBarItem(
            title: title,
            image: UIImage(systemName: imageTitle),
            selectedImage: nil
        )
        
        let navVC = UINavigationController(rootViewController: vc)
        navVC.tabBarItem = tabBarItem
        //navVC.navigationBar.backgroundColor = .white
       
//        navVC.navigationBar.prefersLargeTitles = false
//        
//        let navBarAppearance = UINavigationBarAppearance()
//        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor.black]
//        navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
//        navBarAppearance.backgroundColor = UIColor(named: "MilkBlue") ?? .white
//        
//        navVC.navigationBar.barStyle = .default
//        navVC.navigationBar.standardAppearance = navBarAppearance
//        navVC.navigationBar.scrollEdgeAppearance = navBarAppearance
//        navVC.navigationBar.tintColor = .white
       
        
        return navVC
    }
}

