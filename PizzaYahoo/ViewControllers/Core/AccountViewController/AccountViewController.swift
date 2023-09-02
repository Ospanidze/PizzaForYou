//
//  AccountViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

enum NameField: String, CaseIterable {
    case firstName = "Имя"
    case lastName = "Фамилия"
    case additionalName = "Отчество"
    case dateBirthday = "Дата рождения"
    case gender = "Пол"
}

final class AccountViewController: UITableViewController {
    
    private let userDefaultsManager = UserDefaultsManager.shared
    private let namesFields = NameField.allCases
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Аккаунт"
        view.backgroundColor = .white
      
        tableView.register(
            AccountTableViewCell.self,
            forCellReuseIdentifier: AccountTableViewCell.identifier
        )
        
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Редактировать",
            style: .plain,
            target: self,
            action: #selector(editingTapped))
        getUser()
        print(user)
    }
    
    func changeUser(newUser: User) {
        saveNewEditUser(newUser)
        user = newUser
        tableView.reloadData()
    }
    
    @objc private func editingTapped() {
        let vc = EditingViewController(user)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getUser() {
         user = userDefaultsManager.fetchUser()
    }
    
    private func saveNewEditUser(_ user: User) {
        userDefaultsManager.saveUserValue(NameField.firstName.rawValue, user.firstName)
        userDefaultsManager.saveUserValue(NameField.lastName.rawValue, user.lastName)
        userDefaultsManager.saveUserValue(NameField.additionalName.rawValue, user.additionalName)
        userDefaultsManager.saveUserValue(NameField.dateBirthday.rawValue, user.dateBirthday)
        userDefaultsManager.saveUserValue(NameField.gender.rawValue, user.gender)
    }
}

//MARK: UITableViewDataSource
extension AccountViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        namesFields.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameField = namesFields[indexPath.row].rawValue
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? AccountTableViewCell else {
            return UITableViewCell()
        }
        
        let value = userDefaultsManager.getUserValue(nameField)
        cell.configure(with: nameField, value: value)
        return cell
    }
}

//MARK: UITableViewDelegate
extension AccountViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}
