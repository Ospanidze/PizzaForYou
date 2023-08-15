//
//  AccountViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

final class AccountViewController: UIViewController {

    private let leftView = LeftNavBarView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        setupNavigationBar(leftView)
    }
}


