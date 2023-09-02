//
//  UserDefaultsManager.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import Foundation

final class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private let userDefaults = UserDefaults.standard
    private let key = "user"
    
    private init() {}
    
//    func save(user: User) {
//        var fetchUser = fetchUser()
//        fetchUser = user
//        guard let data = try? JSONEncoder().encode(fetchUser) else { return }
//        userDefaults.set(data, forKey: key)
//    }
//
//    func fetchUser() -> User {
//        guard let data = userDefaults.data(forKey: key) else { return User() }
//        guard let user = try? JSONDecoder().decode(User.self, from: data) else { return User() }
//        return user
//    }
    
//    func deleteOption(at index: Int) {
//        var options = fetchOption()
//        options.remove(at: index)
//        guard let data = try? JSONEncoder().encode(options) else { return }
//        userDefaults.set(data, forKey: key)
//    }
    
    func getUserInfo() -> [String: String] {
        userDefaults.value(forKey: key) as? [String: String] ?? [:]
    }
    
    func saveUserValue(_ key: String, _ value: String) {
        var userInfo = getUserInfo()
        userInfo[key] = value
        userDefaults.set(userInfo, forKey: key)
    }
    
    func fetchUser() -> User {
        var user = User()
        let userInfo = getUserInfo()
        user.firstName = userInfo[NameField.firstName.rawValue] ?? ""
        user.lastName = userInfo[NameField.lastName.rawValue] ?? ""
        user.additionalName = userInfo[NameField.additionalName.rawValue] ?? ""
        user.dateBirthday = userInfo[NameField.dateBirthday.rawValue] ?? ""
        user.gender = userInfo[NameField.gender.rawValue] ?? ""
        
        return user
    }
    
    func getUserValue(_ key: String) -> String {
        let userInfo = getUserInfo()
        let stringValue = userInfo[key] ?? ""
        return stringValue
    }
}
