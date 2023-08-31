//
//  BasketViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

final class BasketViewCell: UITableViewCell {
    
    var quantityChanged: ((Int) -> Void)?
    
    private let networkManager = NetworkManager.shared
    
    private let backdropView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        //view.largeContentImage = UIImage(systemName: "person")
        return view
    }()
    
    private let basketImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(
            systemName: "person"
        )?.withRenderingMode(.alwaysTemplate)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel = UILabel(text: "C рисосм",
                                    font: UIFont.systemFont(ofSize: 16, weight: .bold))
    private let costLabel = UILabel(text: "213tg",
                                    font: UIFont.sfProDisplay(size: 14))
    private let massLabel = UILabel(text: "314g",
                                    font: UIFont.sfProDisplay(size: 14),
                                    textAlignment: .right,
                                    foregroundColor: .systemGray3)
    
    private let plusAndMinusView = PlusAndMinusView()
    
//    private let discriptionLabel = UILabel(text: "sdaаафафаофоылаодлафыаыфд",
//                                           font: UIFont.systemFont(ofSize: 14, weight: .medium))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupLayout()
        selectionStyle = .none
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(cartItem: CartItem) {
        nameLabel.text = cartItem.dish.name
        costLabel.text = "\(cartItem.dish.price)tg"
        massLabel.text = "\(cartItem.dish.weight)g"
        
        plusAndMinusView.valueChanged = { [weak self] newQuantity in
            self?.quantityChanged?(newQuantity)
        }
        plusAndMinusView.configure(beginningCount: cartItem.quantity)
        
        networkManager.fetchImage(from: cartItem.dish.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.basketImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setupViews() {
        
        addSubview(backdropView)
        backdropView.addSubview(basketImageView)
        addSubview(nameLabel)
        addSubview(costLabel)
        addSubview(massLabel)
        contentView.addSubview(plusAndMinusView)
    }

}

extension BasketViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            backdropView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            backdropView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            backdropView.widthAnchor.constraint(equalTo: heightAnchor, multiplier: 0.8),
            //backdropView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
        
        NSLayoutConstraint.activate([
            basketImageView.topAnchor.constraint(equalTo: backdropView.topAnchor),
            basketImageView.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor),
            basketImageView.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor),
            basketImageView.heightAnchor.constraint(equalTo: backdropView.heightAnchor)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            nameLabel.leadingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            nameLabel.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        NSLayoutConstraint.activate([
            costLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor),
            costLabel.leadingAnchor.constraint(equalTo: backdropView.trailingAnchor, constant: 10),
            
            
            massLabel.centerYAnchor.constraint(equalTo: costLabel.centerYAnchor),
            massLabel.leadingAnchor.constraint(equalTo: costLabel.trailingAnchor, constant: 7),
        ])
        
        NSLayoutConstraint.activate([
            plusAndMinusView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            plusAndMinusView.centerYAnchor.constraint(equalTo: centerYAnchor),
            plusAndMinusView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.23),
            plusAndMinusView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.4)
        ])
        
    }
}
