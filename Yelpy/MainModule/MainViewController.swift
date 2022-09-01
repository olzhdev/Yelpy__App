//
//  MainViewController.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import UIKit

class MainViewController: UIViewController, MainViewProtocol {
    // MARK: - Properties & Layout elements
    lazy var contentView: LayoutMainView = .init()
    var presenter: MainPresenterProtocol!
    
    private var lastOffsetY: CGFloat = 0
    
    
    // MARK: - Lifecycle
    override func loadView() {
        view = contentView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setDelegates()
        registerCells()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    // MARK: - Private methods
    /// Setting delegates for collection views
    private func setDelegates() {
        contentView.scrollView.delegate = self
        
        contentView.cousineCollectionView.delegate = self
        contentView.cousineCollectionView.dataSource = self
        
        contentView.foodTypeCollectionView.delegate = self
        contentView.foodTypeCollectionView.dataSource = self
        
        contentView.commonTypeCardCollectionView.delegate = self
        contentView.commonTypeCardCollectionView.dataSource = self
        
        contentView.trendingCollectionView.delegate = self
        contentView.trendingCollectionView.dataSource = self
        contentView.trendingCardView.cardViewDelegate = self
    }
    
    /// Registernig custom cells for collection views
    private func registerCells() {
        contentView.cousineCollectionView.register(CuisineCollectionViewCell.self, forCellWithReuseIdentifier: CuisineCollectionViewCell.identifier)
        contentView.foodTypeCollectionView.register(FoodTypeCollectionViewCell.self, forCellWithReuseIdentifier: FoodTypeCollectionViewCell.identifier)
        contentView.commonTypeCardCollectionView.register(CommonCollectionViewCell.self, forCellWithReuseIdentifier: CommonCollectionViewCell.identifier)
        contentView.trendingCollectionView.register(TrendingCollectionViewCell.self, forCellWithReuseIdentifier: TrendingCollectionViewCell.identifier)
    }
    
    /// NavBar configuration
    private func configureNavBar() {
        let button = UIButton(type: UIButton.ButtonType.custom)
        button.setImage(UIImage(named: "Yelpy_rect2"), for: .normal)
        button.addTarget(self, action: #selector(logoButton), for: .touchDragInside)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        let barButton = UIBarButtonItem(customView: button)
        self.navigationItem.leftBarButtonItems = [barButton]
        
        let locationButton = UIButton()
        locationButton.frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        locationButton.titleLabel?.numberOfLines = 0
        locationButton.titleLabel?.lineBreakMode = .byWordWrapping
        locationButton.titleLabel?.textAlignment = .center
        locationButton.setTitleColor(.secondaryLabel, for: .normal)
        locationButton.setAttributedTitle("Current location:\nNew York City ˅" .getAttributedBoldText(text: "New York City ˅"), for: .normal)
        locationButton.titleLabel?.font = UIFont(name: "AvenirNextLTPro-Regular", size: 15)
        
        navigationItem.titleView = locationButton
    }
    
    @objc private func logoButton() {}
    
    
    // MARK: - ViewProtocol methods
    func success() {
        contentView.trendingCollectionView.reloadData()
    }
    
    func failure(error: Error) {
        print("MainPresenter failure: \(error)")
    }
}


// MARK: - Extensions

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    /// NumberOfItems
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch collectionView {
        case contentView.cousineCollectionView:
            return presenter.cuisineDefaultArray.count
        case contentView.foodTypeCollectionView:
            return presenter.foodTypeDefaultArray.count
        case contentView.commonTypeCardCollectionView:
            return presenter.commonTypeDefaultArray.count
        case contentView.trendingCollectionView:
            return presenter.trendingArray?.count ?? 5
        default: return 0
        }
    }
    
    /// CellForRowItemAt
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        switch collectionView {

        case contentView.cousineCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CuisineCollectionViewCell.identifier, for: indexPath) as! CuisineCollectionViewCell
            
            cell.set(model: .init(model: presenter.cuisineDefaultArray[indexPath.row]))
            
            return cell
            
        case contentView.foodTypeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FoodTypeCollectionViewCell.identifier, for: indexPath) as! FoodTypeCollectionViewCell
            
            cell.set(model: .init(model: presenter.foodTypeDefaultArray[indexPath.row]))
            
            return cell
            
        case contentView.commonTypeCardCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CommonCollectionViewCell.identifier, for: indexPath) as! CommonCollectionViewCell

            cell.set(model: .init(model: presenter.commonTypeDefaultArray[indexPath.row]))
            
            return cell
            
        case contentView.trendingCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TrendingCollectionViewCell.identifier, for: indexPath) as! TrendingCollectionViewCell
            
            if presenter.trendingArray != nil {
                cell.set(viewModel: .init(model: (presenter.trendingArray?[indexPath.row])!))
            }
            
            return cell
            
        default:
            return UICollectionViewCell()
        }
 
    }
    
    ///DidSelectItemAt
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch collectionView {
        case contentView.cousineCollectionView:
            
            let label = presenter.cuisineDefaultArray[indexPath.row].key
            let apiAttribute = presenter.cuisineDefaultArray[indexPath.row].value["APIAttribute"] ?? ""
            
            presenter.didGoToListTapped(categoryName: label, APIAttribute: apiAttribute)
            
        case contentView.foodTypeCollectionView:
            
            let label = presenter.foodTypeDefaultArray[indexPath.row].key
            let apiAttribute = presenter.foodTypeDefaultArray[indexPath.row].value["APIAttribute"] ?? ""
            
            presenter.didGoToListTapped(categoryName: label, APIAttribute: apiAttribute)
            
        case contentView.commonTypeCardCollectionView:
            
            let label = presenter.commonTypeDefaultArray[indexPath.row].key
            let apiAttribute = presenter.commonTypeDefaultArray[indexPath.row].value["APIAttribute"] ?? ""
            
            presenter.didGoToListTapped(categoryName: label, APIAttribute: apiAttribute)

        case contentView.trendingCollectionView:
            
            guard let selectedBusinessID = presenter.trendingArray?[indexPath.row].id else { return }
            
            presenter.didGoToBusinessInfoTapped(businessID: selectedBusinessID)
        default:
            break
        }
    }
    
    ///sizeForItemAt
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case contentView.cousineCollectionView:
            return CGSize(width: CuisineCollectionViewCell.cellWidth, height: CuisineCollectionViewCell.cellHeight)
        case contentView.foodTypeCollectionView:
            return CGSize(width: FoodTypeCollectionViewCell.cellWidth, height: FoodTypeCollectionViewCell.cellHeight)
        case contentView.commonTypeCardCollectionView:
            return CGSize(width: CommonCollectionViewCell.cellWidth, height: CommonCollectionViewCell.cellHeight)
        case contentView.trendingCollectionView:
            return CGSize(width: TrendingCollectionViewCell.cellWidth, height: TrendingCollectionViewCell.cellHeight)
        default:
            return CGSize()
        }
    }
}

extension MainViewController: UIScrollViewDelegate {
    /// 1-2 Functionality of hiding/showing navbar when sccrolling
    /// 1
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView){
        lastOffsetY = scrollView.contentOffset.y
    }
    /// 2
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView){
        let hide = scrollView.contentOffset.y > self.lastOffsetY
        navigationController?.setNavigationBarHidden(hide, animated: true)
    }
}

extension MainViewController: CardViewDelegate {
    
    func didSeeAllButtonTapped(categoryTitle: String, APIAttribute: String) {
        presenter.didGoToListTapped(categoryName: categoryTitle, APIAttribute: APIAttribute)
    }
}
