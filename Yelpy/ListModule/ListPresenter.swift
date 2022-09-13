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
    func showingSpinner(flag: Bool)
    func showingSpinnerInFooter(flag: Bool)
}

protocol ListPresenterProtocol {
    init(view: ListViewProtocol,
         APICaller: APICallerProtocol,
         categoryName: String,
         APIAttribute: String)
    
    var categoryName: String? { get set }
    var APIAttribute: String? { get set }
    var businessesList: [BusinessItem] { get set }
    
    var limiter: Int { get set }
    var count: Int { get set }
    var offset: Int { get set }
    var remaining: Int { get set }
    var priceFilter: String { get set }
    var attributes: String { get set }

    func fetchData(forCategory: String, count: Int, offset: Int, price: String, attributes: String)
    func fetchDataForPagination(offset: Int)
    func setNavBarTitle()
    func didGoToBusinessInfoTapped(businessID: String)
    func didFilterChooseButtonTapped()
    func didNotificationFromFilterModuleReceived()
    
    var completionHandler: ((String) -> Void)? { get set }
    var completionHandler2: (() -> Void)? { get set }
    
    var observer: NSObjectProtocol? { get set }

}


final class ListPresenter: ListPresenterProtocol {
    
    // MARK: - Properties
    weak var view: ListViewProtocol!
    var APICaller: APICallerProtocol!
    var categoryName: String?
    var APIAttribute: String?
    var businessesList: [BusinessItem] = []
    
    var limiter: Int = 5
    lazy var count: Int = limiter
    lazy var offset: Int = limiter
    var remaining: Int = 0

    var priceFilter = "1,2,3,4"
    var attributes = ""

    var completionHandler: ((String) -> Void)?
    var completionHandler2: (() -> Void)?
    
    var observer: NSObjectProtocol?
    
    
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
        fetchData(forCategory: APIAttribute, count: count, offset: 0, price: priceFilter, attributes: attributes)
        setNavBarTitle()
        didNotificationFromFilterModuleReceived()
    }
    

    // MARK: - Methods
    
    func fetchData(forCategory: String, count: Int, offset: Int, price: String, attributes: String) {

        self.view.showingSpinner(flag: true)
        
        APICaller.getBusinessList(forCategory: forCategory, count: count, offset: offset, price: price, attributes: attributes) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let businessesList):
                    self.businessesList = businessesList.businesses
                    self.remaining = businessesList.total - self.count
                    //print("Total: \(businessesList.total) Remainig: \(self.remaining)")
                    self.view.showingSpinner(flag: false)
                    
                    self.view.success()
                case .failure(let error):
                    self.view.failure(error: error)
                }
            }
        }
    }
    
    func didFilterChooseButtonTapped() {
        completionHandler2?()
    }
    
    func didNotificationFromFilterModuleReceived() {
        observer = NotificationCenter.default.addObserver(
            forName: NSNotification.Name("applyFilterAndFetch"),
            object: nil,
            queue: .main,
            using: {[weak self] notification in
                
                guard let self = self else { return }
                guard let object = notification.object as? [String: String] else {return}
                guard let attributes = object["attributes"],
                      let priceFilterAttribute = object["priceFilterAttribute"] else {return}
                
                self.priceFilter = priceFilterAttribute
                self.attributes = attributes
                
                self.fetchData(forCategory: self.APIAttribute!, count: self.count, offset: 0, price: self.priceFilter, attributes: self.attributes)
                
                self.offset = self.limiter
                self.remaining = 0
            })
    }
    
    func fetchDataForPagination(offset: Int) {
        APICaller.getBusinessList(forCategory: APIAttribute!,
                                  count: count,
                                  offset: offset,
                                  price: priceFilter,
                                  attributes: attributes)
        { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let businessesList):
                    self.businessesList.append(contentsOf: businessesList.businesses)
                    self.remaining = businessesList.total - self.count
                    
                    DispatchQueue.main.async {
                        self.view.showingSpinnerInFooter(flag: false)
                    }
                    
                    self.view.success()
                case .failure(let error):
                    self.view.failure(error: error)
                    print(error)
                }
            }
        }
    }

    func setNavBarTitle() {
        view.setNavBarTitle(title: categoryName!)
    }
    
    func didGoToBusinessInfoTapped(businessID: String) {
        completionHandler?(businessID)
    }
}
