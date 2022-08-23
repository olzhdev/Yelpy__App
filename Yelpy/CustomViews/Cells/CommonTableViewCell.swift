//
//  CommonCollectionViewCell.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit

class CommonCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties & Elements

    static let identifier = "CommonCollectionViewCell"
    static let cellWidth: CGFloat = 120
    static let cellHeight: CGFloat = 140
    
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
        backgroundColor = .secondarySystemBackground

        label.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)

        image.backgroundColor = .systemMint
        image.contentMode = .scaleToFill
        image.layer.masksToBounds = true
    }
    
    private func constraint() {
        addSubviews(image, label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            image.bottomAnchor.constraint(equalTo: label.topAnchor, constant: -10),

            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),
        ])
    }
}
