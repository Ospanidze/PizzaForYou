//
//  PresentAlert.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 16.08.2023.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
}
