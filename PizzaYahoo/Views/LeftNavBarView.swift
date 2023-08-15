//
//  LeftNavBarView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 12.08.2023.
//

import UIKit

final class LeftNavBarView: UIView {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(
            named: "place"
        )?.withRenderingMode(.alwaysOriginal)
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let cityNameLabel = UILabel(
        text: "Astana",
        font: .systemFont(ofSize: 17)
    )
    
    private let dateLabel = UILabel(
        text: "12 Август, 2023",
        font: .systemFont(ofSize: 14),
        foregroundColor: .systemGray3
    )
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        //backgroundColor = .white
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(iconImageView)
        addSubview(cityNameLabel)
        addSubview(dateLabel)
    }
}

//MARK: SetupLayout

extension LeftNavBarView {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: topAnchor),
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
        
        NSLayoutConstraint.activate([
            cityNameLabel.topAnchor.constraint(equalTo: topAnchor),
            cityNameLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 5
            ),
            cityNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(
                equalTo: cityNameLabel.bottomAnchor,
                constant: 2
            ),
            dateLabel.leadingAnchor.constraint(
                equalTo: iconImageView.trailingAnchor,
                constant: 5
            ),
            
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            dateLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
}
