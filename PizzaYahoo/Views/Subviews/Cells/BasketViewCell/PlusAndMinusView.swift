//
//  PlusAndMinusView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 14.08.2023.
//

import UIKit

final class PlusAndMinusView: UIView {
    
    var valueChanged: ((Int) -> Void)?
    
    private var count = 1 {
        didSet {
            numberLabel.text = "\(count)"
            valueChanged?(count)
        }
    }
    
    private lazy var plusButton = UIButton(imageString: "plus")
    private lazy var minusButton = UIButton(imageString: "minus")
    private let numberLabel = UILabel(text: "1",
                                      font: UIFont.systemFont(ofSize: 14, weight: .medium),
                                      textAlignment: .center)
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius = 10
        backgroundColor = #colorLiteral(red: 0.950024426, green: 0.9466540217, blue: 0.940451324, alpha: 1)
        setupViews()
        setupLayout()
        
        plusButton.setTitleColor(.gray, for: .highlighted)
        plusButton.layer.cornerRadius = 0
        plusButton.backgroundColor = .none
        plusButton.tag = 0
        minusButton.layer.cornerRadius = 0
        minusButton.backgroundColor = .none
        minusButton.tag = 1
        
        plusButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        minusButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        if sender.tag == 0 {
            guard count < 9 else { return }
            count += 1
        } else {
            guard count > 1 else { return }
            count -= 1
        }
        
    }
    
    private func setupViews() {
        addSubview(plusButton)
        addSubview(minusButton)
        addSubview(numberLabel)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            plusButton.topAnchor.constraint(equalTo: topAnchor),
            plusButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            plusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            plusButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            
            
            minusButton.topAnchor.constraint(equalTo: topAnchor),
            minusButton.trailingAnchor.constraint(equalTo: trailingAnchor),
            minusButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            minusButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.33),
            
            numberLabel.topAnchor.constraint(equalTo: topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: plusButton.trailingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: minusButton.leadingAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}

