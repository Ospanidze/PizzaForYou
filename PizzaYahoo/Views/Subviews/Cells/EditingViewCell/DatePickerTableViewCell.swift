//
//  DatePickerTableViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class DatePickerTableViewCell: UITableViewCell {
    
    static let identifier = "DatePickerTableViewCell"
    
    private let nameLabel = UILabel(
        text: "Aidar",
        font: UIFont(name: "Avenir Next", size: 18)
    )
    
    private let datePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        datePicker.subviews[0].subviews[0].subviews[0].alpha = 0
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupLayout()
        
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String, date: Date) {
        nameLabel.text = name
        datePicker.date = date
    }
    
    func getCellValue() -> String {
        datePicker.date.getStringFromDate()
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        contentView.addSubview(datePicker)
    }
}

//MARK: SetupLayout
extension DatePickerTableViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            datePicker.centerYAnchor.constraint(equalTo: centerYAnchor),
            datePicker.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
        ])
    }
    
}
