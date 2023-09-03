//
//  TextViewTabelViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

protocol NameTextViewProtocol: AnyObject {
    func changeSize()
}

final class TextViewTabelViewCell: UITableViewCell {
    
    static let identifier = "TextViewTabelViewCell"
    
    weak var nameTextViewDelegate: NameTextViewProtocol?
    
    private let nameLabel = UILabel(
        text: "Aidar",
        font: UIFont(name: "Avenir Next", size: 18)
    )
    
    private let nameTextView = NameTextView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        addSubviews()
        setupLayout()
        
        nameTextView.delegate = self
        textViewDidChange(nameTextView)
        layoutIfNeeded()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with name: String, scrollEnabled: Bool, value: String) {
        nameLabel.text = name
        nameTextView.isScrollEnabled = scrollEnabled
        nameTextView.text = value == "" ? "Введите данные" : value
        nameTextView.textColor = .lightGray
    }
    
    func getCellValue() -> String {
        nameTextView.text == "Введите данные" ? "" : nameTextView.text
    }
    
    private func addSubviews() {
        addSubview(nameLabel)
        contentView.addSubview(nameTextView)
    }
}

//MARK: UITextViewDelegate
extension TextViewTabelViewCell: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        contentView.heightAnchor.constraint(
            equalTo: nameTextView.heightAnchor,
            multiplier: 1
        ).isActive = true
        
        nameTextViewDelegate?.changeSize()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == .lightGray {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Введите данные"
            textView.textColor = .lightGray
        }
    }
}

//MARK: SetupLayout
extension TextViewTabelViewCell {
    private func setupLayout() {
        NSLayoutConstraint.activate([
//            heightAnchor.constraint(greaterThanOrEqualToConstant: 70),
            
            nameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35)
        ])
        
        NSLayoutConstraint.activate([
            nameTextView.topAnchor.constraint(equalTo: contentView.topAnchor),
            nameTextView.leadingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: 15),
            nameTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
        ])
    }
    
}

