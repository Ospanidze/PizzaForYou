//
//  SearchCollectionViewCell.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 31.08.2023.
//

import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "SearchCollectionViewCell"
    private let networkManager = NetworkManager.shared
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        //imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(posterImageView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame = contentView.bounds
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with poster: String) {
        
        networkManager.fetchImage(from: poster) { result in
            switch result {
            case .success(let imageData):
                self.posterImageView.image = UIImage(data: imageData)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        
    }
}
