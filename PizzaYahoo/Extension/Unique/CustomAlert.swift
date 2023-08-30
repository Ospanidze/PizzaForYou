//
//  CustomAlert.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

protocol CustomAlertDelegate: AnyObject {
    func selectedDish(_ dish: Dish)
}

final class CustomAlert {
    
    weak var delegate: CustomAlertDelegate?
    
    private var dish: Dish?
    
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.alpha = 0
        return view
    }()
    
    private let alertView = AlertView()
    
    private let scrollView = UIScrollView()
    
    private var mainView: UIView?
    
    func presentCustomAlert(viewController: UIViewController,
                            dish: Dish?) {
        
        guard let parentView = viewController.view else { return }
        mainView = parentView
        self.dish = dish
        guard let food = dish else { return }
        alertView.setupAlertView(dish: food)
        alertView.alertViewDelegate = self
        
        scrollView.frame = parentView.frame
        parentView.addSubview(scrollView)
        
        backgroundView.frame = parentView.frame
        scrollView.addSubview(backgroundView)
        
        alertView.frame = CGRect(x: 40,
                                 y: -parentView.frame.height,
                                 width: parentView.frame.width - 80,
                                 height: parentView.frame.height / 2)
    
        scrollView.addSubview(alertView)
        
        
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.backgroundView.alpha = 0.8
        } completion: { _ in
            UIView.animate(withDuration: 0.45) { [weak self] in
                self?.alertView.center = parentView.center
            }
        }
    }
    
    private func closeButtonTapped() {
        
        guard let targetView = mainView else { return }
        
        UIView.animate(withDuration: 0.4) {
            self.alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.height,
                                          width: targetView.frame.width - 80,
                                          height: targetView.frame.height / 2)
        } completion: { _ in
            UIView.animate(withDuration: 0.4) { [weak self] in
                self?.backgroundView.alpha = 0
            } completion: { [weak self] _ in
                self?.alertView.removeFromSuperview()
                self?.backgroundView.removeFromSuperview()
                self?.scrollView.removeFromSuperview()
            }
        }
    }
}

extension CustomAlert: AlertViewDelegate {
    func cancelAction() {
        closeButtonTapped()
    }
    
    func basketAction() {
        guard let chosenDish = dish else { return }
//        let userInfo: [String: Dish] = ["selectedDish": chosenDish]
//        NotificationCenter.default.post(name: NSNotification.Name("SelectedDishNotification"), object: nil, userInfo: userInfo)
        
        delegate?.selectedDish(chosenDish)

        closeButtonTapped()
    }
}
