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

final class AccountViewController: UIViewController {
    
    private let userDefaultsManager = UserDefaultsManager.shared
    private let nameFields = NameField.allCases
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var user = User()
    private let accountTableView = AccountTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Аккаунт"
        view.backgroundColor = .white
       
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Редактировать",
            style: .plain,
            target: self,
            action: #selector(editingTapped))
        addSubviews()
        setupLayout()
        setValueArray()
        getUser()
        print(user)
        
//        if let bundleIdentifier = Bundle.main.bundleIdentifier {
//            UserDefaults.standard.removePersistentDomain(forName: bundleIdentifier)
//        }
    }
    
    override func viewDidLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
    
    func changeUser(newUser: User) {
        saveNewEditUser(newUser)
        user = newUser
        //accountTableView.reloadData()
        setValueArray()
    }
    
    func changeUserPhoto(image: UIImage?) {
        
        userImageView.image = image
        guard let image = image else { return }
        if let imageData = image.jpegData(compressionQuality: 0.5) {
            userDefaultsManager.saveUser(imageData: imageData)
        }
    }
    
    private func addSubviews() {
        view.addSubview(userImageView)
        view.addSubview(accountTableView)
    }
    
    @objc private func editingTapped() {
        let vc = EditingViewController(user, userImageView.image)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func getUser() {
         user = userDefaultsManager.fetchUser()
         userDefaultsManager.loadUserImageData { [weak self] imageData in
             self?.userImageView.image = UIImage(data: imageData)
        }
    }
    
    private func saveNewEditUser(_ user: User) {
        userDefaultsManager.saveUserValue(NameField.firstName.rawValue, user.firstName)
        userDefaultsManager.saveUserValue(NameField.lastName.rawValue, user.lastName)
        userDefaultsManager.saveUserValue(NameField.additionalName.rawValue, user.additionalName)
        userDefaultsManager.saveUserValue(NameField.dateBirthday.rawValue, user.dateBirthday)
        userDefaultsManager.saveUserValue(NameField.gender.rawValue, user.gender)
    }
    
    private func getValueArray() -> [String] {
        var values: [String] = []
        for key in nameFields {
            let value = userDefaultsManager.getUserValue(key.rawValue)
            values.append(value)
        }
        return values
    }
    
    private func setValueArray() {
        let values = getValueArray()
        accountTableView.configureValueArray(values)
        accountTableView.reloadData()
    }
}

//MARK: SetupLayout
extension AccountViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            accountTableView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 10),
            accountTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            accountTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
