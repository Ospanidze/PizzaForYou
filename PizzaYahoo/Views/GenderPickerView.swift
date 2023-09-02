//
//  GenderPickerView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

enum Genger: String, CaseIterable {
    case none = "Не указано"
    case man = "Мужской"
    case woman = "Женской"
}

protocol GenderPickerViewDelegate: AnyObject {
    func didSelected(row: Int)
}

class GenderPickerView: UIPickerView {
    
    weak var genderDelegate: GenderPickerViewDelegate?
    
    private let genders = Genger.allCases
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension GenderPickerView: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        genders.count
    }
}

extension GenderPickerView: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        genders[row].rawValue
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderDelegate?.didSelected(row: row)
    }
}
