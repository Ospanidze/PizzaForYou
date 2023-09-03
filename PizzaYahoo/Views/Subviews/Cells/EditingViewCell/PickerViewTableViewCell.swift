//
//  PickerViewTableViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class PickerViewTableViewCell: UITableViewCell {
    
    static let identifier = "PickerViewTableViewCell"
    
    private let genders = Genger.allCases
    
    private let nameLabel = UILabel(
        text: "Aidar",
        font: UIFont(name: "Avenir Next", size: 18)
    )
    
    private let genderPickerView = GenderPickerView()
    private let genderTextField = GenderTextField()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupLayout()
        genderPickerView.genderDelegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String, value: String) {
        nameLabel.text = name
        genderTextField.text = value 
    }
    
    func getCellValue() -> String {
        genderTextField.text ?? ""
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        contentView.addSubview(genderTextField)
        genderTextField.inputView = genderPickerView
    }
}

extension PickerViewTableViewCell: GenderPickerViewDelegate {
    func didSelected(row: Int) {
        genderTextField.text = genders[row].rawValue
        genderTextField.resignFirstResponder()
    }
    
}

//MARK: SetupLayout
extension PickerViewTableViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            genderTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            genderTextField.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            genderTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            genderTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
        ])
    }
    
}
