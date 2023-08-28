//
//  GroupColletionView.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 13.08.2023.
//

import UIKit

protocol GroupCollectionViewDelegate: AnyObject {
    func didSelectGroup(at group: Teg)
}

final class GroupCollectionView: UICollectionView {
    
    weak var groupDelegate: GroupCollectionViewDelegate?

    private let idGroup = "idGroup"
    private var groupNames: [Teg] = []
    
    private let collectionFlowLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: collectionFlowLayout)
        
        register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: idGroup)
        
        setupConfigure()
        setupCollectionLayout()
        setupDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupGroupCollectionView(groupNames: [Teg]) {
        self.groupNames = groupNames
        reloadData()
    }
    
    private func setupConfigure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        //backgroundColor = .yellow
    }
    
    private func setupCollectionLayout() {
        collectionFlowLayout.minimumInteritemSpacing = 3
        collectionFlowLayout.scrollDirection = .horizontal
        collectionFlowLayout.collectionView?.showsHorizontalScrollIndicator = false
    }
    
    private func setupDelegate() {
        dataSource = self
        delegate = self
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension GroupCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        groupNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let name = groupNames[indexPath.item]
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: idGroup,
            for: indexPath
        )
        
        guard let groupCell = cell as? GroupCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        groupCell.setupCell(groupName: name.rawValue)
        return groupCell
    }
}

//MARK: UICollectionViewDelegate

extension GroupCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let groupName = groupNames[indexPath.item]
        //print(groupName)
        groupDelegate?.didSelectGroup(at: groupName)
    }
}

//MARK: UICollectionViewDelegateFlowLayout

extension GroupCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(
            width: collectionView.bounds.width / 4,
            height: collectionView.bounds.width / 7.7
        )
    }
}
