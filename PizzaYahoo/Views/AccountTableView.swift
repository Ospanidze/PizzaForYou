//
//  AccountTableView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 03.09.2023.
//

import UIKit

final class AccountTableView: UITableView {
    
    private let nameFields = NameField.allCases
    private var values: [String] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        translatesAutoresizingMaskIntoConstraints = false
        delegate = self
        dataSource = self
        
        register(
            AccountTableViewCell.self,
            forCellReuseIdentifier: AccountTableViewCell.identifier
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureValueArray(_ values: [String]) {
        self.values = values
    }
}

//MARK: UITableViewDataSource
extension AccountTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        nameFields.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let nameField = nameFields[indexPath.row].rawValue
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountTableViewCell.identifier,
            for: indexPath
        )
        guard let cell = cell as? AccountTableViewCell else {
            return UITableViewCell()
        }
        
        //let value = userDefaultsManager.getUserValue(nameField)
        let value = values[indexPath.row]
        cell.configure(with: nameField, value: value)
        return cell
    }
}

//MARK: UITableViewDelegate
extension AccountTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        indexPath.row == 1 ? UITableView.automaticDimension : 44
    }
}
