//
//  LayoutBusinessDetailVC.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit
import SkeletonView
import MapKit

/// Layout of BusinessDetailVC, element configs and constraints
final class LayoutBusinessDetailVC: UIView {
    
    // MARK: - Layout Elements
    /// Root Elements
    var scrollView = UIScrollView()
    var headerContainerView = UIView()
    var imageView = UIImageView()
    let contentView = UIView()
    
    /// ContentView Elements
    let nameLabel = UILabel()
    let categoryLabel = UILabel()
    let ratingLabel = UILabel()
    let ratingSymbol = UIImageView()
    let locationLabel = UILabel()
    let locationSymbol = UIImageView()
    let phoneLabel = UILabel()
    let phoneSymbol = UIImageView()
    let reviewCountLabel = UILabel()
    let reviewCountSymbol = UIImageView()
    
    let photosCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let padding: CGFloat = 0
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = padding
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    let pageControll = UIPageControl()
    let mapView = MKMapView()
    let favoriteButton = UIButton()
    let websiteButton = UIButton()
    
    
    // MARK: - Inits
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        configureUI()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    
    private func configureUI() {
        scrollView.backgroundColor = .secondarySystemBackground
        scrollView.layer.masksToBounds = true
        
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 20
        contentView.layer.masksToBounds = true
        
        headerContainerView.backgroundColor = .gray
        
        imageView.clipsToBounds = true
        imageView.backgroundColor = .systemOrange
        imageView.contentMode = .scaleAspectFill
        
        nameLabel.font = UIFont(name: "AvenirNextLTPro-Bold", size: 23)
        nameLabel.numberOfLines = 2
        
        let favoriteButtonImageName = "plus"
        favoriteButton.setImage(UIImage(systemName: favoriteButtonImageName), for: .normal)
        favoriteButton.tintColor = .systemOrange
        favoriteButton.imageView?.layer.transform = CATransform3DMakeScale(1.5, 1.5, 1.5)
        
        categoryLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 18)
        categoryLabel.numberOfLines = 2
        categoryLabel.textColor = .secondaryLabel
        
        locationLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        locationSymbol.image = UIImage(systemName: "location.circle.fill")
        locationSymbol.tintColor = .systemOrange
        
        phoneSymbol.image = UIImage(systemName: "phone.circle.fill")
        phoneSymbol.tintColor = .systemOrange
        phoneLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        ratingSymbol.image = UIImage(systemName: "star.circle.fill")
        ratingSymbol.tintColor = .systemOrange
        ratingLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        reviewCountSymbol.image = UIImage(systemName: "bubble.right.circle.fill")
        reviewCountSymbol.tintColor = .systemOrange
        reviewCountLabel.font = UIFont(name: "AvenirNextLTPro-Regular", size: 19)
        
        photosCollectionView.layer.cornerRadius = 15
        photosCollectionView.layer.masksToBounds = true
        photosCollectionView.showsHorizontalScrollIndicator = false
        photosCollectionView.backgroundColor = .systemOrange
        
        mapView.backgroundColor = .systemMint
        mapView.layer.cornerRadius = 15
        mapView.layer.masksToBounds = true
        
        websiteButton.backgroundColor = .systemOrange
        websiteButton.setTitle("Go to website", for: .normal)
        websiteButton.layer.cornerRadius = 15
        websiteButton.layer.masksToBounds = true
        
    }
    
    private func constraint() {
        addSubview(scrollView)
        scrollView.addSubviews(headerContainerView, contentView)
        headerContainerView.addSubview(imageView)
        
        // ScrollView Constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // Content View Constraints
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            //contentView.heightAnchor.constraint(equalToConstant: 600),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 280)
        ])
        
        
        // Main Layout
        contentView.addSubviews(nameLabel, categoryLabel, ratingLabel, ratingSymbol, locationLabel, locationSymbol,  photosCollectionView, phoneLabel, phoneSymbol, reviewCountLabel, pageControll, reviewCountSymbol, mapView, favoriteButton, websiteButton)
        
        [nameLabel, categoryLabel, ratingLabel, ratingSymbol, locationLabel, locationSymbol,  photosCollectionView, phoneLabel, phoneSymbol, reviewCountLabel, pageControll, reviewCountSymbol, mapView, favoriteButton, websiteButton].forEach({$0.translatesAutoresizingMaskIntoConstraints = false})
        
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            nameLabel.bottomAnchor.constraint(equalTo: categoryLabel.topAnchor, constant: -15),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: favoriteButton.leadingAnchor, constant: -10),
            
            favoriteButton.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor),
            favoriteButton.widthAnchor.constraint(equalToConstant: 50),
            favoriteButton.heightAnchor.constraint(equalTo: favoriteButton.widthAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            categoryLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            categoryLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            categoryLabel.bottomAnchor.constraint(equalTo: locationSymbol.topAnchor, constant: -15),
            
            locationSymbol.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            locationSymbol.heightAnchor.constraint(equalToConstant: 20),
            locationSymbol.widthAnchor.constraint(equalTo: phoneSymbol.heightAnchor),
            locationSymbol.bottomAnchor.constraint(equalTo: phoneSymbol.topAnchor, constant: -10),
            
            locationLabel.centerYAnchor.constraint(equalTo: locationSymbol.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationSymbol.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
            phoneSymbol.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            phoneSymbol.heightAnchor.constraint(equalToConstant: 20),
            phoneSymbol.widthAnchor.constraint(equalTo: phoneSymbol.heightAnchor),
            phoneSymbol.bottomAnchor.constraint(equalTo: ratingSymbol.topAnchor, constant: -10),
            
            phoneLabel.centerYAnchor.constraint(equalTo: phoneSymbol.centerYAnchor),
            phoneLabel.leadingAnchor.constraint(equalTo: phoneSymbol.trailingAnchor, constant: 5),
            phoneLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            
            ratingSymbol.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            ratingSymbol.heightAnchor.constraint(equalToConstant: 20),
            ratingSymbol.widthAnchor.constraint(equalTo: ratingSymbol.heightAnchor),
            ratingSymbol.bottomAnchor.constraint(equalTo: photosCollectionView.topAnchor, constant: -20),
            
            ratingLabel.leadingAnchor.constraint(equalTo: ratingSymbol.trailingAnchor, constant: 5),
            ratingLabel.centerYAnchor.constraint(equalTo: ratingSymbol.centerYAnchor),
            
            reviewCountSymbol.leadingAnchor.constraint(equalTo: ratingLabel.trailingAnchor, constant: 15),
            reviewCountSymbol.heightAnchor.constraint(equalToConstant: 20),
            reviewCountSymbol.widthAnchor.constraint(equalTo: reviewCountSymbol.heightAnchor),
            reviewCountSymbol.centerYAnchor.constraint(equalTo: ratingLabel.centerYAnchor),
            
            reviewCountLabel.leadingAnchor.constraint(equalTo: reviewCountSymbol.trailingAnchor, constant: 5),
            reviewCountLabel.centerYAnchor.constraint(equalTo: reviewCountSymbol.centerYAnchor),
            
            photosCollectionView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            photosCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            photosCollectionView.bottomAnchor.constraint(equalTo: mapView.topAnchor, constant: -20),
            photosCollectionView.heightAnchor.constraint(equalToConstant: PhotoSliderCollectionViewCell.preferredHeight),
            
            pageControll.centerXAnchor.constraint(equalTo: photosCollectionView.centerXAnchor),
            pageControll.bottomAnchor.constraint(equalTo: photosCollectionView.bottomAnchor, constant: -5),
            
            mapView.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            mapView.bottomAnchor.constraint(equalTo: websiteButton.topAnchor, constant: -25),
            mapView.heightAnchor.constraint(equalToConstant: 170),
            
            websiteButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            websiteButton.heightAnchor.constraint(equalToConstant: 50),
            websiteButton.widthAnchor.constraint(equalToConstant: 130),
            websiteButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        
        // Header Container Constraints
        let headerContainerViewBottom : NSLayoutConstraint!
        
        headerContainerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerContainerView.topAnchor.constraint(equalTo: topAnchor),
            headerContainerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            headerContainerView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
        
        headerContainerViewBottom = headerContainerView.bottomAnchor.constraint(equalTo: contentView.topAnchor, constant: 15)
        headerContainerViewBottom.priority = UILayoutPriority(rawValue: 900)
        headerContainerViewBottom.isActive = true
        
        // ImageView Constraints
        let imageViewTopConstraint: NSLayoutConstraint!
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: headerContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: headerContainerView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: headerContainerView.bottomAnchor)
        ])
        
        imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: topAnchor)
        imageViewTopConstraint.priority = UILayoutPriority(rawValue: 900)
        imageViewTopConstraint.isActive = true
    }
    
}
