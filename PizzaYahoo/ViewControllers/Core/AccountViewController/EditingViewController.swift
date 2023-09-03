//
//  EditingViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class EditingViewController: UIViewController {
    
    private let nameFields = NameField.allCases
    private let editingTableView = EditingTableView()
    private var user = User()
    
    private var isSaveTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Редактирование"
        view.backgroundColor = .white
        
        addSubviews()
        setupLayout()
        navigationItem.rightBarButtonItem?.tintColor = .label
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Сохранить",
            style: .plain,
            target: self,
            action: #selector(saveButtonTapped))
        let barButtonItem = UIBarButtonItem.createCustomButton(vc: self, selector: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = barButtonItem
        editingTableView.setupUser(user)
    }
    
    init(_ user: User) {
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(editingTableView)
    }
    
    @objc private func saveButtonTapped() {
        let editUser = editingTableView.getUser()
        
        if authFields(user: editUser) {
            presentAlert(title: "Выполнено", message: nil)
            isSaveTapped = true
        } else {
            presentAlert(title: "Ошибка", message: "Заполните поля ФИО, дата рождения и пол")
        }
        print(editingTableView.getUser())
    }
    
    @objc private func backButtonTapped() {
        
        let editUser = editingTableView.getUser()
        
        if editUser == user {
            navigationController?.popViewController(animated: true)
        } else if isSaveTapped {
            guard let accountVC = self.navigationController?.viewControllers.first as? AccountViewController else {
                return
            }
            
            accountVC.changeUser(newUser: editUser)
            navigationController?.popViewController(animated: true)
        } else {
            presentChangeAlert { [weak self] changed in
                guard let self = self else { return }
                if changed {
                    if self.authFields(user: editUser) {
                        guard let accountVC = self.navigationController?.viewControllers.first as? AccountViewController else {
                            return
                        }
                        accountVC.changeUser(newUser: editUser)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.presentAlert(title: "Ошибка", message: "Заполните поля ФИО, дата рождения и пол")
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        isSaveTapped = false
    }
    
    private func authFields(user: User) -> Bool {
        if user.firstName == "Введите данные"
            || user.lastName == "Введите данные"
            || user.dateBirthday == ""
            || user.gender == ""
            || user.gender == "Не указано" {
            return false
        }
        return true
    }

}

extension EditingViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            editingTableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
