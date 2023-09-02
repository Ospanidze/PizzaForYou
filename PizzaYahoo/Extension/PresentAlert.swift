//
//  PresentAlert.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 16.08.2023.
//

import UIKit

extension UIViewController {
    
    func presentAlert(title: String, message: String?) {
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: true)
    }
    
    func presentChangeAlert(completion: @escaping(Bool) -> Void) {
        let alert = UIAlertController(
            title: "Данные были изменены",
            message: "Вы желаете изменить, в противном случае внесенные правки будут отменены",
            preferredStyle: .alert
        )
        
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            completion(true)
        }
        let skipAction = UIAlertAction(title: "Пропустить", style: .default) { _ in
            completion(false)
        }
        alert.addAction(saveAction)
        alert.addAction(skipAction)
        
        present(alert, animated: true)
    }
}
