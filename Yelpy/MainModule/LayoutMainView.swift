//
//  LayoutHomeVC.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit

/// HomeViewController layout: elements, configurations and constraints
final class LayoutMainView: UIView {
    
    // MARK: - Properties & Elements
    
    let scrollView = UIScrollView()
    private let contentView = UIView()
    
    let cuisineCard = CardView(categoryTitle: "Cusinie 🍽", cellWidth: CuisineCollectionViewCell.cellWidth, cellHeight: CuisineCollectionViewCell.cellHeight)
    lazy var cousineCollectionView = cuisineCard.collectionView
    
    let foodTypeCard = CardView(categoryTitle: "Category 🍕", cellWidth: FoodTypeCollectionViewCell.cellWidth, cellHeight: FoodTypeCollectionViewCell.cellHeight)
    lazy var foodTypeCollectionView = foodTypeCard.collectionView
    
    let commonTypeCard = CardView(categoryTitle: "Your summer mood ☀️", cellWidth: CommonCollectionViewCell.cellWidth, cellHeight: CommonCollectionViewCell.cellHeight)
    lazy var commonTypeCardCollectionView = commonTypeCard.collectionView
    
    let trendingCardView = CardView(categoryTitle: "Hot & Tranding 🔥", cellWidth: TrendingCollectionViewCell.cellWidth, cellHeight: TrendingCollectionViewCell.cellHeight, isButtonHiden: false, APIAttribute: "hot_and_tranding")
    lazy var trendingCollectionView = trendingCardView.collectionView
    
    
    // MARK: - Inits
    
    override init(frame: CGRect){
        super.init(frame: frame)
        
        configureUI()
        mainViewConstraint()
        constraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Private
    
    private func configureUI() {
        backgroundColor = .secondarySystemBackground
    }
    

    private func constraint() {
        contentView.addSubviews(cuisineCard, foodTypeCard, commonTypeCard, trendingCardView)
        
        /// Views
        NSLayoutConstraint.activate([
            cuisineCard.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 10),
            cuisineCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cuisineCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cuisineCard.heightAnchor.constraint(equalToConstant: cuisineCard.prefferedHeight),
            cuisineCard.bottomAnchor.constraint(equalTo: foodTypeCard.topAnchor, constant: -15),
            
            foodTypeCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            foodTypeCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            foodTypeCard.heightAnchor.constraint(equalToConstant: foodTypeCard.prefferedHeight),
            foodTypeCard.bottomAnchor.constraint(equalTo: commonTypeCard.topAnchor, constant: -15),
            
            commonTypeCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            commonTypeCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            commonTypeCard.heightAnchor.constraint(equalToConstant: commonTypeCard.prefferedHeight),
            commonTypeCard.bottomAnchor.constraint(equalTo: trendingCardView.topAnchor, constant: -15),
            
            trendingCardView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            trendingCardView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            trendingCardView.heightAnchor.constraint(equalToConstant: trendingCardView.prefferedHeight),
            trendingCardView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -100),
        ])
    }
    
    private func mainViewConstraint() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        /// Scroll view and Content View
        let contentViewCenterY = contentView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        contentViewCenterY.priority = .defaultLow
        
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: scrollView.heightAnchor)
        contentViewHeight.priority = .defaultLow
        
        NSLayoutConstraint.activate([
            
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            scrollView.centerXAnchor.constraint(equalTo: centerXAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            contentViewCenterY,
            contentViewHeight
        ])
    }
    
}
