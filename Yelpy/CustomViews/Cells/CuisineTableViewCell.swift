//
//  CategoryCollectionViewCell.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit

class CuisineCollectionViewCell: UICollectionViewCell {
    // MARK: - Properties & Elements

    static let identifier = "CategoryCollectionViewCell"
    static let cellWidth: CGFloat = 130
    static let cellHeight: CGFloat = 170
    
    private let label = UILabel()
    private let image = UIImageView()
    private let tintView = UIView()
    
    struct ViewModel {
        let label: String
        let imageName: String
        
        init(model: (key: String, value: [String : String])) {
            self.label = model.key
            self.imageName = model.value["imageName"] ?? ""
        }
    }

    
    // MARK: - Init
    
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
        label.text = nil
        image.image = nil
    }

    
    // MARK: - Public

    public func set(model: ViewModel) {
        self.label.text = model.label
        self.image.image = UIImage(named: model.imageName)
    }
    
    
    // MARK: - Private
    
    private func configureUI() {
        layer.cornerRadius = 15
        layer.masksToBounds = true
        
        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 23)
        label.textColor = .white

        image.backgroundColor = .systemMint
        
        tintView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        tintView.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
    }
    
    private func constraint() {
        addSubviews(image, tintView, label)

        label.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),

            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -7),
        ])
    }
}
