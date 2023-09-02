//
//  EditingTableView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 02.09.2023.
//

import UIKit

final class EditingTableView: UITableView {
    
    private let nameFields = NameField.allCases
    private var user = User()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        translatesAutoresizingMaskIntoConstraints = false
        register(
            TextViewTabelViewCell.self,
            forCellReuseIdentifier: TextViewTabelViewCell.identifier
        )
        
        register(
            DatePickerTableViewCell.self,
            forCellReuseIdentifier: DatePickerTableViewCell.identifier
        )
        
        register(
            PickerViewTableViewCell.self,
            forCellReuseIdentifier: PickerViewTableViewCell.identifier
        )
        delegates()
    }
    
    func setupUser(_ user: User) {
        self.user = user
    }
    
    func editUser() {
        guard let firstNameCell = self.cellForRow(at: [0, 0]) as? TextViewTabelViewCell,
              let LastNameCell = self.cellForRow(at: [0, 1]) as? TextViewTabelViewCell,
              let addNameCell = self.cellForRow(at: [0, 2]) as? TextViewTabelViewCell,
              let dateBirthdayCell = self.cellForRow(at: [0, 3]) as? DatePickerTableViewCell,
              let genderCell = self.cellForRow(at: [0, 4]) as? PickerViewTableViewCell else {
            return
        }
        
        user.firstName = firstNameCell.getCellValue()
        user.lastName = LastNameCell.getCellValue()
        user.additionalName = addNameCell.getCellValue()
        user.dateBirthday = dateBirthdayCell.getCellValue()
        user.gender = genderCell.getCellValue()
    }
    
    func getUser() -> User {
        editUser()
        return user
    }
    
    private func delegates() {
        dataSource = self
        delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: UITableViewDataSource
extension EditingTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let nameField = nameFields[indexPath.row].rawValue
        
        switch indexPath.row {
        case 0...2:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: TextViewTabelViewCell.identifier,
                for: indexPath
            )
            guard let cell = cell as? TextViewTabelViewCell else {
                return UITableViewCell()
            }
            
            cell.nameTextViewDelegate = self
            switch indexPath.row {
            case 0:
                cell.configure(with: nameField, scrollEnabled: true, value: user.firstName)
            case 1:
                cell.configure(with: nameField, scrollEnabled: false, value: user.lastName)
            default:
                cell.configure(with: nameField, scrollEnabled: true, value: user.additionalName)
            }
            
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: DatePickerTableViewCell.identifier,
                for: indexPath
            )
            guard let cell = cell as? DatePickerTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: nameField, date: user.dateBirthday.getDateFromString())
            
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: PickerViewTableViewCell.identifier,
                for: indexPath
            )
            guard let cell = cell as? PickerViewTableViewCell else {
                return UITableViewCell()
            }
            
            cell.configure(with: nameField, value: user.gender)
            
            return cell
        default:
            return UITableViewCell()
        }
    }
}

//MARK: UITableViewDelegate
extension EditingTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}

extension EditingTableView: NameTextViewProtocol {
    func changeSize() {
        beginUpdates()
        endUpdates()
    }
}
