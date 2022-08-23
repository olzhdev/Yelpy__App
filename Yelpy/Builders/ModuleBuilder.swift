//
//  ModuleBuilder.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import Foundation
import UIKit

protocol ModuleBuilderProtocol {
    func buildMainModule() -> MainViewController
    func buildFavoritesModule() -> FavoritesViewController
    func buildListModule(categoryName: String, APIAttribute: String) -> ListViewController
    func buildDetailModule(businessID: String) -> DetailViewController
    //func buildSearchModule(router: RouterProtocol) -> UIViewController()

}

class ModuleBuilder: ModuleBuilderProtocol {
    
    
    func buildMainModule() -> MainViewController {
        let view = MainViewController()
        let APICaller = APICaller()

        let presenter = MainPresenter(view: view, APICaller: APICaller)
        view.presenter = presenter
        
        return view
    }
    
    func buildListModule(categoryName: String, APIAttribute: String) -> ListViewController {
        let view = ListViewController()
        let APICaller = APICaller()
        
        let presenter = ListPresenter(view: view, APICaller: APICaller, categoryName: categoryName, APIAttribute: APIAttribute)
        view.presenter = presenter
        
        return view
    }
    
    func buildDetailModule(businessID: String) -> DetailViewController {
        let view = DetailViewController()
        let APICaller = APICaller()
        let persistanceManager = PersistanceManager()
        
        let presenter = DetailPresenter(view: view, APICaller: APICaller, persistanceManager: persistanceManager, businessID: businessID)
        view.presenter = presenter
        
        return view
    }
    
    
    func buildFavoritesModule() -> FavoritesViewController {
        let view = FavoritesViewController()
        let persistanceManager = PersistanceManager()
        let presenter = FavoritesPresenter(view: view, persistanceManager: persistanceManager)
        view.presenter = presenter
        
        return view
    }
    
    
}
