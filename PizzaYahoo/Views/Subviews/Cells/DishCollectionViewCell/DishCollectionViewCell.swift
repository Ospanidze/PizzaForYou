//
//  ResearchCollectionViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 12.08.2023.
//

import UIKit

final class DishCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "DishCollectionViewCell"
    
    private let networkManager = NetworkManager.shared
   
    private let dishBackdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.largeContentImage = UIImage(systemName: "person")
        return view
    }()
    
    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(
            systemName: "person"
        )?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
//        imageView.layer.cornerRadius = 10
//        imageView.layer.borderWidth = 1
//        imageView.layer.borderColor = UIColor.black.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Pizza"
        label.numberOfLines = 2
        label.minimumScaleFactor = 10
        label.font = UIFont.sfProDisplay(size: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupLayout()
        //backgroundColor = .systemGray5
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with dish: Dish) {
        dishNameLabel.text = dish.name
        
        networkManager.fetchImage(from: dish.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.dishImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        addSubview(dishBackdropView)
        dishBackdropView.addSubview(dishImageView)
        addSubview(dishNameLabel)
    }
}

extension DishCollectionViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            dishBackdropView.topAnchor.constraint(equalTo: topAnchor),
            dishBackdropView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dishBackdropView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dishBackdropView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65)
        ])
        
        NSLayoutConstraint.activate([
            dishImageView.topAnchor.constraint(equalTo: dishBackdropView.topAnchor),
            dishImageView.leadingAnchor.constraint(equalTo: dishBackdropView.leadingAnchor),
            dishImageView.trailingAnchor.constraint(equalTo: dishBackdropView.trailingAnchor),
            dishImageView.heightAnchor.constraint(equalTo: dishBackdropView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dishNameLabel.topAnchor.constraint(equalTo: dishBackdropView.bottomAnchor),
            dishNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            dishNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            dishNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
