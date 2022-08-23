//
//  PhotoSliderCollectionViewCell.swift
//  Yelpy
//
//  Created by MAC
//


import UIKit
import SDWebImage

class PhotoSliderCollectionViewCell: UICollectionViewCell {
    // MARK: - Layout elements and properties
    
    static let identifier = "PhotoSliderCollectionViewCell"
    static let preferredHeight: CGFloat = 170
    
    private let image = UIImageView()
    
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)

        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
    }
    
    
    //MARK: - Public
    
    public func set(imageURL: String) {
        self.image.sd_setImage(with: URL(string: imageURL), completed: nil)
    }
    
    
    //MARK: - Private

    private func configure() {
        backgroundColor = .systemOrange
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "Placeholder_horiz")
        
        addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor),
            image.trailingAnchor.constraint(equalTo: trailingAnchor),
            image.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])

    }
}

