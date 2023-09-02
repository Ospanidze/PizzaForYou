//
//  ext + String.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 03.09.2023.
//

import UIKit

extension String {
    
    func getDateFromString() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let date = dateFormatter.date(from: self) ?? Date()
        return date
    }
}
