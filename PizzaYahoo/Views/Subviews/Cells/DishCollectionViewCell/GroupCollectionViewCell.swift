//
//  GroupCollectionViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

final class GroupCollectionViewCell: UICollectionViewCell {
    
    private let groupNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.sfProDisplay(size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                layer.borderColor = UIColor.red.cgColor
            } else {
                layer.borderColor = UIColor.black.cgColor
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        setConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    
    private func setupView() {
        
        layer.borderWidth = 2
        layer.cornerRadius = 10
        
        addSubview(groupNameLabel)
        
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            groupNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            groupNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
//            foodNameLabel.leadingAnchor.constraint(
//                equalTo: leadingAnchor,
//                constant: 10
//            )
        ])
    }
    
    func setupCell(groupName: String) {
        groupNameLabel.text = groupName
    }
}
