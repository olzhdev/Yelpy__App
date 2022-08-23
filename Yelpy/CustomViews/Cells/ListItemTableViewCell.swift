//
//  BusinessesListItemTableViewCell.swift
//  Yelpy
//
//  Created by MAC
//

/*
import UIKit

class ListItemTableViewCell: UITableViewCell {
    
    // MARK: - Properties & Elements
    
    /// Cell identifier
    static let identifier = "BusinessesListItemTableViewCell"
    /// Height of cell
    static let prefferedHeight: CGFloat = 300
    /// Layout elements
    private let image = UIImageView()
    private let nameLabel = UILabel()
    private let addressLabel = UILabel()
    private let categoryLabel = UILabel()
    private let ratingLabel = UILabel()
    private let ratingSymbol = UIImageView()
    private let priceLabel = UILabel()
    private let isClosedLabel = UILabel()
    private let isClosedBackground = UIView()
    private let filterSegmentedControl = UISegmentedControl()
    private var imageURL: String!
    
    struct ViewModel {
        let nameLabel: String
        let addressLabel: String
        let categoryLabel: String
        let ratingLabel: String
        let priceLabel: String
        let isClosedLabel: String
        let imageURL: String
        
        init(model: BusinessItem) {
            self.nameLabel = model.name
            self.addressLabel = model.location.address1 ?? ""
            self.categoryLabel = model.categories.map({$0.title}).joined(separator: ", ")
            self.ratingLabel = model.stringRating
            self.priceLabel = model.price ?? ""
            self.isClosedLabel = model.formattedIsClosed
            self.imageURL = model.imageURL
        }
        
        init(model: BusinessItemSD) {
            self.nameLabel = model.name ?? ""
            self.addressLabel = model.location ?? ""
            self.categoryLabel = model.categories ?? ""
            self.ratingLabel = model.rating ?? ""
            self.priceLabel = model.price ?? ""
            self.isClosedLabel = model.isClosedLabel ?? ""
            self.imageURL = model.imageURL ?? ""
        }
    }
    

    // MARK: - Inits
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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
        addressLabel.text = nil
        priceLabel.text = nil
        isClosedLabel.text = nil
        image.image = nil
    }
    
    
    // MARK: - Public
    
    public func set(viewModel: ViewModel) {
        self.nameLabel.text = viewModel.nameLabel
        self.categoryLabel.text = viewModel.categoryLabel
        self.ratingLabel.text = viewModel.ratingLabel
        self.addressLabel.text = viewModel.addressLabel
        self.priceLabel.text = viewModel.priceLabel
        self.isClosedLabel.text = viewModel.isClosedLabel
        self.image.sd_setImage(with: URL(string: viewModel.imageURL), completed: nil)
    }
    
    
    // MARK: - Private
    private func configureUI() {
        backgroundColor = .systemBackground
        layer.cornerRadius = 15
        clipsToBounds = true
        
        nameLabel.font = UIFont(name: "AvenirNextLTPro-Bold", size: 23)
        
        categoryLabel.textColor = .secondaryLabel
        categoryLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        addressLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        addressLabel.textColor = .tertiaryLabel

        ratingLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)

        ratingSymbol.image = UIImage(systemName: "star.fill")
        ratingSymbol.tintColor = .systemOrange
        
        priceLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        priceLabel.textAlignment = .center

        image.backgroundColor = .gray
        image.image = UIImage(named: "Placeholder_horiz")
        image.backgroundColor = .systemOrange
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 15
        
        isClosedLabel.font = .systemFont(ofSize: 20)
        
        isClosedBackground.layer.cornerRadius = 15
        isClosedBackground.layer.masksToBounds = true
        isClosedBackground.layer.maskedCorners = [.layerMinXMinYCorner]
        isClosedBackground.backgroundColor = .systemBackground
        isClosedBackground.alpha = 0.7

    }
    
    
    private func constraint() {
        addSubviews(image, nameLabel, categoryLabel, ratingLabel, ratingSymbol, addressLabel, priceLabel, isClosedBackground, isClosedLabel)
        
        [image, nameLabel, categoryLabel, ratingLabel, ratingSymbol, addressLabel, priceLabel, isClosedBackground, isClosedLabel].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            image.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            image.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -10),
            image.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.60),
        
            isClosedBackground.bottomAnchor.constraint(equalTo: image.bottomAnchor),
            isClosedBackground.trailingAnchor.constraint(equalTo: image.trailingAnchor),
            isClosedBackground.heightAnchor.constraint(equalToConstant: 40),
            isClosedBackground.widthAnchor.constraint(equalToConstant: 115),
            
            isClosedLabel.centerYAnchor.constraint(equalTo: isClosedBackground.centerYAnchor),
            isClosedLabel.centerXAnchor.constraint(equalTo: isClosedBackground.centerXAnchor),
            
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            nameLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -5),
            
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: ratingSymbol.topAnchor, constant: -10),
            
            ratingSymbol.leadingAnchor.constraint(equalTo: categoryLabel.leadingAnchor),
            ratingSymbol.heightAnchor.constraint(equalToConstant: 15),
            ratingSymbol.widthAnchor.constraint(equalTo: ratingSymbol.heightAnchor),
            ratingSymbol.trailingAnchor.constraint(equalTo: ratingLabel.leadingAnchor, constant: -5),
            //ratingSymbol.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            ratingLabel.centerYAnchor.constraint(equalTo: ratingSymbol.centerYAnchor),
            ratingLabel.widthAnchor.constraint(equalToConstant: 30),
            ratingLabel.trailingAnchor.constraint(equalTo: priceLabel.leadingAnchor, constant: -5),
            
            priceLabel.centerYAnchor.constraint(equalTo: ratingSymbol.centerYAnchor),
            priceLabel.widthAnchor.constraint(equalToConstant: 50),
            priceLabel.trailingAnchor.constraint(equalTo: addressLabel.leadingAnchor, constant: -5),
            
            addressLabel.centerYAnchor.constraint(equalTo: ratingSymbol.centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }

}


*/
