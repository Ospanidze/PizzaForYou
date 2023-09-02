//
//  NameTextView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class NameTextView: UITextView {
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        translatesAutoresizingMaskIntoConstraints = false
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        text = "Введите данные"
        textColor = .lightGray
        textAlignment = .right
        isScrollEnabled = false
        font = UIFont(name: "Avenir Next", size: 18)
    }
}
