//
//  MainPresenter.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import Foundation

protocol MainViewProtocol: AnyObject {
    func success()
    func failure(error: Error)
}

protocol MainPresenterProtocol {
    init(view: MainViewProtocol,
         APICaller: APICallerProtocol)
    func fetchData()
    func didGoToListTapped(categoryName: String, APIAttribute: String)
    func didGoToBusinessInfoTapped(businessID: String)
    
    var completionHandler: ((String, String) -> Void)? { get set }
    var completionHandler2: ((String) -> Void)? { get set }
    
    var trendingArray: [BusinessItem]? { get set }
    var cuisineDefaultArray: [String: [String: String]] { get set }
    var foodTypeDefaultArray: [String: [String: String]] { get set }
    var commonTypeDefaultArray: [String: [String: String]] { get set }

}


class MainPresenter: MainPresenterProtocol {
    // MARK: - Properties
    weak var view: MainViewProtocol!
    var APICaller: APICallerProtocol!
    
    var trendingArray: [BusinessItem]?
    var cuisineDefaultArray = DefaultArrays.cuisineDefaultArray
    var foodTypeDefaultArray = DefaultArrays.foodTypeDefaultArray
    var commonTypeDefaultArray = DefaultArrays.commonTypeDefaultArray
    
    var completionHandler: ((String, String) -> Void)?
    var completionHandler2: ((String) -> Void)?
    
    
    // MARK: - Init
    required init(view: MainViewProtocol, APICaller: APICallerProtocol) {
        self.view = view
        self.APICaller = APICaller
        fetchData()
    }
    
    
    // MARK: - Methods
    func fetchData() {
        APICaller.getBusinessList(forCategory: "hot_and_tranding",
                                  count: 5,
                                  offset: 0,
                                  price: "1,2,3,4")
        { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let trendingArray):
                self.trendingArray = trendingArray.businesses
                
                DispatchQueue.main.async {
                    self.view.success()
                }
                
            case .failure(let error):
                self.view.failure(error: error)
            }
        }
    }
    
    func didGoToListTapped(categoryName: String, APIAttribute: String) {
        /// Go to business detail
        completionHandler?(categoryName, APIAttribute)
    }
    
    func didGoToBusinessInfoTapped(businessID: String) {
        /// Go to buisnesses list
        completionHandler2?(businessID)
    }


    
}
