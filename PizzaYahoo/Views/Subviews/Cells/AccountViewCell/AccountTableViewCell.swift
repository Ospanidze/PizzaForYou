//
//  AccountTableViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class AccountTableViewCell: UITableViewCell {
    
    static let identifier = "AccountTableViewCell"
    
    private let nameLabel = UILabel(
        text: "Aidar",
        font: UIFont(name: "Avenir Next", size: 18)
    )
    
    private let valueLabel = UILabel(
        text: "adadsd",
        font: UIFont(name: "Avenir Next", size: 18),
        textAlignment: .right
    )
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value == "" ? "Нет данных" : value
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        addSubview(valueLabel)
    }
}

extension AccountTableViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            heightAnchor.constraint(greaterThanOrEqualToConstant: 44),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            valueLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            valueLabel.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            valueLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
        ])
    }
    
}
