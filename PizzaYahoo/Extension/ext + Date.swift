//
//  ext + Date.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 03.09.2023.
//

import Foundation

extension Date {
    
    func getStringFromDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}
