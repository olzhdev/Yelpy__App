//
//  ListPresenter.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import Foundation

protocol ListViewProtocol: AnyObject {
    func setNavBarTitle(title: String)
    func success()
    func failure(error: Error)
}

protocol ListPresenterProtocol: AnyObject {
    init(view: ListViewProtocol,
         APICaller: APICallerProtocol,
         categoryName: String,
         APIAttribute: String)
    
    var categoryName: String? { get set }
    var APIAttribute: String? { get set }
    var businessesList: [BusinessItem] { get set }
    
    var count: Int { get set }
    var offset: Int { get set }
    var remaining: Int { get set }
    var priceFilter: String { get set }

    func fetchData(forCategory: String, count: Int, offset: Int, price: String)
    func fetchDataForPagination(offset: Int)
    func setNavBarTitle()
    func didGoToBusinessInfoTapped(businessID: String)
    func didSegmentedValueChanged(selectedIndex: String)
    
    var completionHandler: ((String) -> Void)? { get set }
}

class ListPresenter: ListPresenterProtocol {
    // MARK: - Properties
    weak var view: ListViewProtocol!
    var APICaller: APICallerProtocol!
    var categoryName: String?
    var APIAttribute: String?
    var businessesList: [BusinessItem] = []
    
    var count: Int = 5
    var remaining: Int = 0
    lazy var offset: Int = count
    var priceFilter = "1,2,3,4"

    var completionHandler: ((String) -> Void)?
    
    
    // MARK: - Init
    required init(view: ListViewProtocol,
                  APICaller: APICallerProtocol,
                  categoryName: String,
                  APIAttribute: String)
    {
        self.view = view
        self.APICaller = APICaller
        self.categoryName = categoryName
        self.APIAttribute = APIAttribute
        fetchData(forCategory: APIAttribute, count: count, offset: 0, price: priceFilter)
        setNavBarTitle()
    }
    
    
    // MARK: - Methods
    func fetchData(forCategory: String, count: Int, offset: Int, price: String) {
        ///Show spinner
        APICaller.getBusinessList(forCategory: forCategory, count: count, offset: offset, price: price) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let businessesList):
                    self.businessesList = businessesList.businesses
                    self.remaining = businessesList.total - self.count
                    DispatchQueue.main.async {
                        ///Remove spinner
                    }
                    self.view.success()
                case .failure(let error):
                    self.view.failure(error: error)
                }
            }
        }
    }

    
    func didSegmentedValueChanged(selectedIndex: String) {
        fetchData(forCategory: APIAttribute!, count: count, offset: 0, price: selectedIndex)
    }
    
    func fetchDataForPagination(offset: Int) {
        APICaller.getBusinessList(forCategory: APIAttribute!, count: count, offset: offset, price: priceFilter) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let businessesList):
                    self.businessesList.append(contentsOf: businessesList.businesses)
                    self.remaining = businessesList.total - self.count
                    DispatchQueue.main.async {
                        ///Remove spinner
                    }
                    self.view.success()
                case .failure(let error):
                    self.view.failure(error: error)
                    print(error)
                }
            }
        }    }

    
    func setNavBarTitle() {
        view.setNavBarTitle(title: categoryName!)
    }
    
    func didGoToBusinessInfoTapped(businessID: String) {
        completionHandler?(businessID)
    }
}
