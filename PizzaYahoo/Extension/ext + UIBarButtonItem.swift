//
//  ext + UIBarButtonItem.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 03.09.2023.
//

import UIKit

extension UIBarButtonItem {
    
    static func createCustomButton(vc: UIViewController, selector: Selector) -> UIBarButtonItem {
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setTitle("Назад", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17)
        button.tintColor = .systemBlue
        button.addTarget(vc, action: selector, for: .touchUpInside)
        
        let barButtonItem = UIBarButtonItem(customView: button)
        return barButtonItem
    }
}
