//
//  DescriptionViewController.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 31.08.2023.
//

import UIKit

final class DescriptionViewController: UIViewController {
    
    private let networkManager = NetworkManager.shared
    
    private let backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.largeContentImage = UIImage(systemName: "person")
        return view
    }()
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var heartButton = UIButton(imageString: "heart")
    private lazy var cancelButton = UIButton(imageString: "x.circle")
    
    private let nameLabel = UILabel(
        text: "C рисосм",
        font: UIFont.systemFont(ofSize: 24, weight: .heavy)
    )
    private let costLabel = UILabel(
        text: "213tg",
        font: UIFont.sfProDisplay(size: 18)
    )
    
    private let massLabel = UILabel(
        text: "314g",
        font: UIFont.sfProDisplay(size: 18),
        textAlignment: .right,
        foregroundColor: .systemGray3
    )
    
    private let descriptionLabel = UILabel(
        text: "sdaаафафаофоылаодлафыаыфд",
        font: UIFont.headlineText(size: 20),
        textAlignment: .center
    )
                                
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupViews()
        setupLayout()
        
//        descriptionLabel.layer.borderWidth = 1
//        descriptionLabel.layer.borderColor = UIColor.red.cgColor
//        descriptionLabel.layer.cornerRadius = 10
        //cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        //basketButton.addTarget(self, action: #selector(basketButtonAction), for: .touchUpInside)
    }
    
    func configure(with dish: Dish) {
        nameLabel.text = dish.name
        costLabel.text = "\(dish.price)tg"
        massLabel.text = "\(dish.weight)g"
        descriptionLabel.text = dish.description

        networkManager.fetchImage(from: dish.imageURL) {[weak self] result in
            switch result {
            case .success(let imageData):
                self?.dishImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    private func setupViews() {
        
        view.addSubview(backdropView)
        backdropView.addSubview(dishImageView)
        backdropView.addSubview(heartButton)
        backdropView.addSubview(cancelButton)
        view.addSubview(nameLabel)
        view.addSubview(costLabel)
        view.addSubview(massLabel)
        view.addSubview(descriptionLabel)
    }
}

extension DescriptionViewController {
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backdropView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            backdropView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            backdropView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: backdropView.topAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor),
            dishImageView.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor),
            dishImageView.heightAnchor.constraint(equalTo: backdropView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: dishImageView.topAnchor, constant: 5),
            cancelButton.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -10),
            cancelButton.widthAnchor.constraint(equalToConstant: 50),
            cancelButton.heightAnchor.constraint(equalToConstant: 50),
            
            heartButton.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -5),
            heartButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 50),
            heartButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backdropView.bottomAnchor, constant: 5),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            nameLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            costLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            costLabel.heightAnchor.constraint(equalToConstant: 25),
            
            massLabel.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
            massLabel.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 7),
            massLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 5),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            descriptionLabel.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.25),
        ])
        
    }
}
