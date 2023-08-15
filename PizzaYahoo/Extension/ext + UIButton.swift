//
//  ext + UIButton.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

extension UIButton {
    
    convenience init(imageString: String) {
        self.init(frame: .zero)
        self.setImage(UIImage(systemName: imageString), for: .normal)
        self.backgroundColor = .white
        self.tintColor = .black
        self.layer.cornerRadius = 10
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
