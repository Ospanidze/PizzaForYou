//
//  AlertView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

protocol AlertViewDelegate: AnyObject {
    func cancelAction()
    
    func basketAction()
}

final class AlertView: UIView {
    
    weak var alertViewDelegate: AlertViewDelegate?
    
    var isTapped = false {
        didSet {
            basketButton.backgroundColor = isTapped ? .systemGreen : .blue
        }
    }
    
    private let networkManager = NetworkManager.shared
    
    private let backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.largeContentImage = UIImage(systemName: "person")
        return view
    }()
    
    private let alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(
            systemName: "person"
        )?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var heartButton = UIButton(imageString: "heart")
    private lazy var cancelButton = UIButton(imageString: "x.circle")
    
    private let nameLabel = UILabel(
        text: "C рисосм",
        font: UIFont.systemFont(ofSize: 16, weight: .heavy)
    )
    private let costLabel = UILabel(
        text: "213tg",
        font: UIFont.sfProDisplay(size: 14)
    )
    
    private let massLabel = UILabel(
        text: "314g",
        font: UIFont.sfProDisplay(size: 14),
        textAlignment: .right,
        foregroundColor: .systemGray3
    )
    
    private let discriptionLabel = UILabel(
        text: "sdaаафафаофоылаодлафыаыфд",
        font: UIFont.headlineText(size: 16)
    )
                                
    private lazy var basketButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.setTitle("Добавить в корзину", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        button.backgroundColor = .blue
        button.tintColor = .white
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 15
        setupViews()
        setupLayout()
        
        cancelButton.addTarget(self, action: #selector(cancelButtonAction), for: .touchUpInside)
        basketButton.addTarget(self, action: #selector(basketButtonAction), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupAlertView(dish: Dish) {
        nameLabel.text = dish.name
        costLabel.text = "\(dish.price)tg"
        massLabel.text = "\(dish.weight)g"
        discriptionLabel.text = dish.description
        isTapped = false
        networkManager.fetchImage(from: dish.imageURL) {[weak self] result in
            switch result {
            case .success(let imageData):
                self?.alertImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
    
    @objc private func cancelButtonAction() {
        alertViewDelegate?.cancelAction()
    }
    
    @objc private func basketButtonAction() {
        isTapped = true
        alertViewDelegate?.basketAction()
    }
    
    private func setupViews() {
        
        addSubview(backdropView)
        backdropView.addSubview(alertImageView)
        backdropView.addSubview(heartButton)
        backdropView.addSubview(cancelButton)
        addSubview(nameLabel)
        addSubview(costLabel)
        addSubview(massLabel)
        addSubview(discriptionLabel)
        addSubview(basketButton)
    }
}

extension AlertView {
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backdropView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backdropView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            backdropView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
        
        NSLayoutConstraint.activate([
            alertImageView.topAnchor.constraint(equalTo: backdropView.topAnchor),
            alertImageView.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor),
            alertImageView.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor),
            alertImageView.heightAnchor.constraint(equalTo: backdropView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cancelButton.topAnchor.constraint(equalTo: alertImageView.topAnchor, constant: 5),
            cancelButton.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: -10),
            cancelButton.widthAnchor.constraint(equalToConstant: 40),
            cancelButton.heightAnchor.constraint(equalToConstant: 40),
            
            heartButton.trailingAnchor.constraint(equalTo: cancelButton.leadingAnchor, constant: -5),
            heartButton.centerYAnchor.constraint(equalTo: cancelButton.centerYAnchor),
            heartButton.widthAnchor.constraint(equalToConstant: 40),
            heartButton.heightAnchor.constraint(equalToConstant: 40),
        ])
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: backdropView.bottomAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            costLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            massLabel.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
            massLabel.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 7),
        ])
        
        NSLayoutConstraint.activate([
            basketButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            basketButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            basketButton.heightAnchor.constraint(equalToConstant: 60),
            basketButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            discriptionLabel.topAnchor.constraint(equalTo: costLabel.bottomAnchor, constant: 5),
            discriptionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            discriptionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            discriptionLabel.bottomAnchor.constraint(equalTo: basketButton.topAnchor, constant: -5),
        ])
        
        
    }
}
