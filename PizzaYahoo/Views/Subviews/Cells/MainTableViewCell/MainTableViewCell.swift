//
//  MainTableViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import UIKit

final class MainTableViewCell: UITableViewCell {
    
//    var category: Сategory?
    private let networkManager = NetworkManager.shared
    
    private var image: UIImage? {
        didSet {
            bgImageView.image = image
            activityIndicator.hidesWhenStopped = true
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    }
    
    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.color = .black
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.startAnimating()
        return activityIndicator
    }()
    
    private let backdropView: UIView = {
        let view = UIView()
        //view.backgroundColor = .yellow
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        view.largeContentImage = UIImage(systemName: "person")
        return view
    }()
    
    private let bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage().withRenderingMode(.alwaysTemplate)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Pizza"
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupViews()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell(category: Сategory) {
        titleLabel.text = category.name
        
        networkManager.fetchImage(from: category.imageURL) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    private func setupViews() {
        addSubview(backdropView)
        backdropView.addSubview(bgImageView)
        backdropView.addSubview(titleLabel)
        bgImageView.addSubview(activityIndicator)
    }
}

//MARK: SetupLayout

extension MainTableViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
            backdropView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            backdropView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            backdropView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            backdropView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
        
        NSLayoutConstraint.activate([
            bgImageView.topAnchor.constraint(equalTo: backdropView.topAnchor),
            bgImageView.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor),
            bgImageView.trailingAnchor.constraint(equalTo: backdropView.trailingAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: backdropView.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: backdropView.topAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: backdropView.leadingAnchor, constant: 8),
            titleLabel.heightAnchor.constraint(equalToConstant: 60),
            titleLabel.widthAnchor.constraint(equalTo: backdropView.widthAnchor, multiplier: 0.6)
        ])
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: backdropView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: backdropView.centerYAnchor)
        ])
    }
}
