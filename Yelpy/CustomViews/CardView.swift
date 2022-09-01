//
//  CardView.swift
//  Yelpy
//
//  Created by MAC
//

import UIKit

protocol CardViewDelegate: AnyObject {
    func didSeeAllButtonTapped(categoryTitle: String, APIAttribute: String)
}

/// Custom CardView with CollectionView to add in HomeVC
final class CardView: UIView {
    
    // MARK: - Properties & Elements
    
    /// Delegate
    weak var cardViewDelegate: CardViewDelegate!
    
    /// PreferredHeight of card, computed based on given cellHeight
    var prefferedHeight: CGFloat {
        return cellHeight + 70
    }
    
    /// Given cell parameters
    var cellHeight: CGFloat = 0
    var cellWidth: CGFloat = 0
    
    /// Card Parameters
    private var isSeeAllButtonVisible = true
    private var APIAttribute = ""
    private var categoryTitle = ""
    
    /// Layout elements
    private let categoryLabel = UILabel()
    private let seeAllButton = UIButton()
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        let padding: CGFloat = 10
        layout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        layout.minimumLineSpacing = padding

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        return collectionView
    }()
    
    private let padding: CGFloat = 10

    
    // MARK: - Inits

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        clipsToBounds = true
        translatesAutoresizingMaskIntoConstraints = false
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(
        categoryTitle: String,
        cellWidth: CGFloat,
        cellHeight: CGFloat)
    {
        self.init(frame: .zero)
        self.categoryLabel.text = categoryTitle
        self.categoryTitle = categoryTitle
        self.cellWidth = cellWidth
        self.cellHeight = cellHeight
        constraint()
    }
    
    convenience init(
        categoryTitle: String,
        cellWidth: CGFloat,
        cellHeight: CGFloat,
        isButtonHiden: Bool,
        APIAttribute: String)
    {
        self.init(categoryTitle: categoryTitle, cellWidth: cellWidth, cellHeight: cellHeight)
        self.seeAllButton.isHidden = isButtonHiden
        self.APIAttribute = APIAttribute
    }
    
    
    //MARK: - Private
    
    /// Call delegate when "See All" button tapped
    @objc private func openList() {
        cardViewDelegate.didSeeAllButtonTapped(categoryTitle: categoryTitle, APIAttribute: APIAttribute)
    }
    
    private func configureUI() {
        collectionView.backgroundColor = .systemBackground
        backgroundColor = .systemBackground
        
        categoryLabel.font = .systemFont(ofSize: 22)
        categoryLabel.font = UIFont(name: "AvenirNextLTPro-Bold", size: 23)

        seeAllButton.setTitle("See All", for: .normal)
        seeAllButton.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 20)
        seeAllButton.setTitleColor(.secondaryLabel, for: .normal)
        seeAllButton.isHidden = isSeeAllButtonVisible
        seeAllButton.addTarget(self, action: #selector(openList), for: .touchUpInside)
    }
    
    private func constraint() {
        addSubviews(categoryLabel, collectionView, seeAllButton)
        
        categoryLabel.translatesAutoresizingMaskIntoConstraints = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        seeAllButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            categoryLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            categoryLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            categoryLabel.trailingAnchor.constraint(equalTo: seeAllButton.trailingAnchor, constant: -5),
            categoryLabel.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -5),
            
            seeAllButton.centerYAnchor.constraint(equalTo: categoryLabel.centerYAnchor),
            seeAllButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
     
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

