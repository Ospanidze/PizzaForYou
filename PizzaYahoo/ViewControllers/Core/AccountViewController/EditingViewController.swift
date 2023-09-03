//
//  EditingViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit
import PhotosUI

final class EditingViewController: UIViewController {
    
    private let nameFields = NameField.allCases
    private let editingTableView = EditingTableView()
    private var isSaveTapped = false
    private var isUserPhotoChanged = false
    
    private var user = User()
    
    private let userImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    init(_ user: User, _ userPhoto: UIImage?) {
        self.user = user
        self.userImageView.image = userPhoto
        super.init(nibName: nil, bundle: nil)
    }
    
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
        addTaps()
    }
    
    override func viewDidLayoutSubviews() {
        userImageView.layer.cornerRadius = userImageView.frame.height / 2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addSubviews() {
        view.addSubview(userImageView)
        view.addSubview(editingTableView)
    }
    
    @objc private func saveButtonTapped() {
        let editUser = editingTableView.getUser()
        print(editUser)
        if authFields(user: editUser) {
            presentAlert(title: "Выполнено", message: nil)
            isSaveTapped = true
        } else {
            presentAlert(title: "Ошибка", message: "Заполните поля ФИО, дата рождения и пол")
        }
    }
    
    @objc private func backButtonTapped() {
        
        let editUser = editingTableView.getUser()
        print(editUser)
        if editUser == user && isUserPhotoChanged == false {
            navigationController?.popViewController(animated: true)
        } else if isSaveTapped {
            guard let accountVC = navigationController?.viewControllers.first as? AccountViewController else {
                return
            }
            accountVC.changeUser(newUser: editUser)
            accountVC.changeUserPhoto(image: userImageView.image)
          
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
                        accountVC.changeUserPhoto(image: self.userImageView.image)
                        self.navigationController?.popViewController(animated: true)
                    } else {
                        self.presentAlert(title: "Ошибка", message: "Заполните поля ФИО, дата рождения и пол")
                    }
                } else {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    private func authFields(user: User) -> Bool {
        if user.firstName == "" 
            || user.lastName == ""
            || user.dateBirthday == ""
            || user.gender == ""
            || user.gender == "Не указано" {
            return false
        } else if user.firstName == "Введите данные"
                    || user.lastName == "Введите данные" {
            return false
        }
        return true
    }
    
    private func addTaps() {
        let tapImageView = UITapGestureRecognizer(target: self, action: #selector(setUserPhoto))
        userImageView.isUserInteractionEnabled = true
        userImageView.addGestureRecognizer(tapImageView)
    }
    
    @objc private func setUserPhoto() {
        if #available(iOS 14.0, *) {
            presentPHPicker()
        } else {
            presentImagePicker()
        }
        
    }
}

//MARK: UINavigationControllerDelegate, UIImagePickerControllerDelegate
extension EditingViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private func presentImagePicker() {
        
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            present(imagePicker, animated: true)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as? UIImage
        userImageView.image = image
        isUserPhotoChanged = true
        dismiss(animated: true)
    }
}

//MARK: PHPickerViewControllerDelegate
@available(iOS 14.0, *)
extension EditingViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        results.forEach { result in
            result.itemProvider.loadObject(ofClass: UIImage.self) { reading, error in
                guard let image = reading as? UIImage, error == nil else { return }
                DispatchQueue.main.async { [weak self] in
                    self?.userImageView.image = image
                }
                self.isUserPhotoChanged = true
            }
        }
        picker.dismiss(animated: true, completion: .none)
    }
    
    private func presentPHPicker() {
        var phPickerConfiguration = PHPickerConfiguration(photoLibrary: .shared())
        phPickerConfiguration.selectionLimit = 1
        phPickerConfiguration.filter = PHPickerFilter.any(of: [.images])
        
        let phPickerVC = PHPickerViewController(configuration: phPickerConfiguration)
        phPickerVC.delegate = self
        present(phPickerVC, animated: true)
    }
}

extension EditingViewController {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor,
                constant: 10
            ),
            userImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            userImageView.heightAnchor.constraint(equalToConstant: 100),
            userImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        
        NSLayoutConstraint.activate([
            editingTableView.topAnchor.constraint(
                equalTo: userImageView.bottomAnchor,
                constant: 10
            ),
            editingTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            editingTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            editingTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
}
