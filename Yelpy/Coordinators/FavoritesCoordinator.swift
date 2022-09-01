//
//  FavoritesCoordinator.swift
//  Yelpy
//
//  Created by MAC on 23.08.2022.
//

import UIKit

/// Coordinator of FavoritesFlow
final class FavoritesCoordinator: Coordinator {
    
    var navigationController: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    var flowCompletionHandler: (() -> ())?
    
    var businessesID: String?
            
    
    init(navController: UINavigationController, moduleBuilder: ModuleBuilderProtocol) {
        self.navigationController = navController
        self.moduleBuilder = moduleBuilder
    }
    
    
    func startFirstView() -> UINavigationController? {
        guard let favoritesModule = moduleBuilder?.buildFavoritesModule() else { return nil }
        
        favoritesModule.presenter.completionHandler = { [weak self] businessesID in
            self?.businessesID = businessesID
            self?.showDetailView()
        }
        
        navigationController?.viewControllers = [favoritesModule]
        
        return navigationController
    }
    
    func showDetailView() {
        guard let detailModule = moduleBuilder?.buildDetailModule(businessID: businessesID ?? "") else { return }
        
        detailModule.presenter.completionHandler = {}
        
        navigationController?.pushViewController(detailModule, animated: true)
    }
}
