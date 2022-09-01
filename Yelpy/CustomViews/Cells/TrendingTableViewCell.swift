//
//  TrendingCollectionViewCell.swift
//  Yelpy
//
//  Created by MAC
//


import UIKit
import SDWebImage

final class TrendingCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Layout elements and properties
    
    static let identifier = "TrendingCollectionViewCell"
    static let cellWidth: CGFloat = 180
    static let cellHeight: CGFloat = 270
    
    private let nameLabel = UILabel()
    private let categoryLabel = UILabel()
    private let ratingSymbol = UIImageView()
    private let ratingLabel = UILabel()
    private let image = UIImageView()

    struct ViewModel {
        let nameLabel: String
        let categoryLabel: String
        let ratingLabel: String
        let imageURL: String
        
        init(model: BusinessItem) {
            self.nameLabel = model.name
            self.categoryLabel = model.categories.map({$0.title}).joined(separator: ", ")
            self.ratingLabel = model.stringRating
            self.imageURL = model.imageURL
        }
    }
   
    
    // MARK: - Inits
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        categoryLabel.text = nil
        ratingLabel.text = nil
        image.image = nil
    }
    
    
    
    //MARK: - Public

    public func set(viewModel: ViewModel) {
        self.nameLabel.text = viewModel.nameLabel
        self.categoryLabel.text = viewModel.categoryLabel
        self.ratingLabel.text = viewModel.ratingLabel
        self.image.sd_setImage(with: URL(string: viewModel.imageURL), completed: nil)
    }
    
    
    //MARK: - Private
    
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        nameLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        categoryLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 15)
        categoryLabel.textColor = .secondaryLabel

        ratingLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 13)
        
        ratingSymbol.image = UIImage(systemName: "star.fill")
        ratingSymbol.tintColor = .systemOrange

        image.backgroundColor = .systemOrange
        image.layer.cornerRadius = 10
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
    }
    
    private func constraint() {
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingSymbol.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false

        addSubviews(nameLabel, categoryLabel, ratingLabel, ratingSymbol, image)
        
        let padding: CGFloat = 5
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.65),
            image.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -padding),
            
            nameLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            nameLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -padding),
            
            categoryLabel.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: ratingSymbol.topAnchor, constant: -padding-5),
            
            ratingSymbol.leadingAnchor.constraint(equalTo: image.leadingAnchor),
            ratingSymbol.heightAnchor.constraint(equalToConstant: 15),
            ratingSymbol.widthAnchor.constraint(equalTo: ratingSymbol.heightAnchor),
            ratingSymbol.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingSymbol.trailingAnchor, constant: padding),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingSymbol.centerYAnchor),
            
        ])
    }
    
}
