//
//  MainCoordinator.swift
//  Yelpy
//
//  Created by MAC on 20.08.2022.
//

import UIKit

/// Coordinator of MainFlow
final class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    var flowCompletionHandler: (() -> ())?
    
    var businessesID: String?
    var categoryName: String?
    var APIAttribute: String?
      
    
    init(navController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navController
        self.moduleBuilder = moduleBuilder
    }
    
    
    func startFirstView() -> UINavigationController? {
        guard let mainModule = moduleBuilder?.buildMainModule() else { return nil }
        
        mainModule.presenter.completionHandler = { [weak self] (categoryName, APIAttribute) in
            guard let self = self else { return }
            self.categoryName = categoryName
            self.APIAttribute = APIAttribute
            self.showListView()
        }
        
        mainModule.presenter.completionHandler2 = { businessesID in
            self.businessesID = businessesID
            self.showDetailView()
        }
        
        navigationController?.viewControllers = [mainModule]
        return navigationController
    }
    
    func showListView() {
        guard let listModule = moduleBuilder?.buildListModule(
            categoryName: categoryName ?? "",
            APIAttribute: APIAttribute ?? "") else { return }
        
        listModule.presenter.completionHandler = { [weak self] businessesID in
            guard let self = self else { return }
            self.businessesID = businessesID
            self.showDetailView()
        }
        
        listModule.presenter.completionHandler2 = {
            self.showFilterView()
        }
        
        navigationController?.pushViewController(listModule, animated: true)
    }
    
    func showDetailView() {
        guard let detailModule = moduleBuilder?.buildDetailModule(businessID: businessesID ?? "") else { return }
        
        detailModule.presenter.completionHandler = {}
        
        navigationController?.pushViewController(detailModule, animated: true)
    }
    
    func showFilterView() {
        guard let filterModule = moduleBuilder?.buildFilterModule() else { return }
        
        filterModule.presenter.completionHandler = { [weak self] in
            self?.dismissFilterView()
        }
        
        navigationController?.present(filterModule, animated: true)
    }
    
    func dismissFilterView() {
        navigationController?.dismiss(animated: true, completion: nil)
    }
}
