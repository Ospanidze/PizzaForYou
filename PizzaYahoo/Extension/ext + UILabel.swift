//
//  ext + UILabel.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 12.08.2023.
//

import UIKit

extension UILabel {
    
    convenience init(text: String, font: UIFont?, textAlignment: NSTextAlignment = .left, foregroundColor: UIColor = .black) {
        self.init()
        
        self.text = text
        self.font = font
        self.textColor = foregroundColor
        self.textAlignment = textAlignment
        self.numberOfLines = 0
        self.adjustsFontSizeToFitWidth = true
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
