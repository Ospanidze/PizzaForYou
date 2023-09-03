//
//  User.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import Foundation

struct User: Hashable {
    var firstName = ""
    var lastName = ""
    var additionalName = ""
    var dateBirthday = ""
    var gender = ""
    
    static func == (_ firstModel: User, _ secondModel: User ) -> Bool {
        firstModel.firstName == secondModel.firstName &&
        firstModel.lastName == secondModel.lastName &&
        firstModel.additionalName == secondModel.additionalName &&
        firstModel.gender == secondModel.gender
    }
}
