//
//  DetailViewController.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import UIKit
import MapKit
import SafariServices

final class DetailViewController: UIViewController, DetailViewProtocol {
    // MARK: - Properties & Elements
    lazy var contentView: LayoutBusinessDetailVC = .init()
    var presenter: DetailPresenterProtocol!
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photosSliderCollectionViewConfig()
        contentView.pageControll.currentPage = 0
        contentView.websiteButton.addTarget(self, action: #selector(websiteButtonTapped), for: .touchUpInside)
        contentView.favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.tintColor = .systemOrange
        navigationController?.setNavigationBarHidden(false, animated: true)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.0)
    }
    

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        navigationController?.navigationBar.shadowImage = nil
    }
    
    
    // MARK: - Private methods
    
    /// Calls SafariVC when button tapped
    @objc private func websiteButtonTapped() {
        let url = URL(string: presenter.businessURL ?? "yelp.com")
        let safariVC = SFSafariViewController(url: url!)
                                              
        safariVC.preferredBarTintColor = .systemOrange
        
        present(safariVC, animated: true)
    }
    
    @objc func favoriteButtonTapped() {
        presenter.didFavoriteButtonTapped()
    }
    
    private func photosSliderCollectionViewConfig() {
        contentView.photosCollectionView.delegate = self
        contentView.photosCollectionView.dataSource = self
        contentView.photosCollectionView.register(PhotoSliderCollectionViewCell.self, forCellWithReuseIdentifier: PhotoSliderCollectionViewCell.identifier)
        contentView.photosCollectionView.isPagingEnabled = true
    }
    
    
    // MARK: - ViewProtocol methods
    
    /// Sets coordinates and annotation to business coordinates
    func setMapCoordinatesAndAnnotation(longitude: Double, latitude: Double) {
        contentView.mapView.centerLocation(
            CLLocation(
                latitude: latitude,
                longitude: longitude))
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(
            latitude: latitude,
            longitude: longitude)
        
        contentView.mapView.addAnnotation(annotation)
    }
    
    /// Shows alert by given title and message
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        present(alertVC, animated: true)
    }
    
    /// Sets properties of layout elements (text for label etc)
    func formLayoutProperties(model: Business) {
        self.contentView.nameLabel.text = model.name
        self.contentView.categoryLabel.text = model.categories.map({$0.title}).joined(separator: ", ")
        self.contentView.locationLabel.text = model.location.displayAddress.map({$0}).joined(separator: ", ")
        self.contentView.ratingLabel.text = model.stringRating
        self.contentView.phoneLabel.text = model.displayPhone
        self.contentView.reviewCountLabel.text = model.stringFormattedReviewCount
        self.contentView.imageView.sd_setImage(with: URL(string: model.imageURL), completed: nil)
        self.contentView.pageControll.numberOfPages = presenter.images.count
        self.contentView.photosCollectionView.reloadData()
    }
    
    
    func failure(error: Error) {
        print("DetailPresenter failure: \(error)")
        showAlert(title: "Something went wrong", message: "Please, try again later")
    }
    
    /// Shows skeleton depends on flag
    /// - Parameter flag: True = show, False = hide
    func showSkeleton(flag: Bool) {
        if flag {
            [contentView.nameLabel,
             contentView.categoryLabel,
             contentView.locationLabel,
             contentView.reviewCountLabel,
             contentView.phoneLabel,
             contentView.ratingLabel].forEach({
                $0.isSkeletonable = true
                $0.showAnimatedSkeleton()
            })
            
        } else {
            [contentView.nameLabel,
             contentView.categoryLabel,
             contentView.locationLabel,
             contentView.reviewCountLabel,
             contentView.phoneLabel,
             contentView.ratingLabel].forEach({
                $0.hideSkeleton()
            })
        }
    }

}


// MARK: - Extesnions

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    /// NumberOfItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.images.count
    }
    
    /// CellForItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoSliderCollectionViewCell.identifier, for: indexPath) as! PhotoSliderCollectionViewCell
        
        cell.set(imageURL: presenter.images[indexPath.item])

        return cell
    }
    
    /// SizeForItemAT
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollPos = round(scrollView.contentOffset.x / view.frame.width)
        contentView.pageControll.currentPage = Int(scrollPos)
    }
}
