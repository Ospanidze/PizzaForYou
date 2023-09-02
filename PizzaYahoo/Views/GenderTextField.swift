//
//  GenderTextField.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class GenderTextField: UITextField {
    
    private let padding = UIEdgeInsets(
        top: 0,
        left: 30,
        bottom: 0,
        right: 5
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        !isFirstResponder
    }
    
    private func configure() {
        let font = UIFont(name: "Avenir Next", size: 18)
        translatesAutoresizingMaskIntoConstraints = false
        textAlignment = .right
        tintColor = .clear
        self.font = font
        
        attributedPlaceholder = NSAttributedString(
            string: "Введите данные", 
            attributes: [
                NSAttributedString.Key.foregroundColor: UIColor.lightGray,
                NSAttributedString.Key.font: font as Any
            ]
        )

        
    }
}
