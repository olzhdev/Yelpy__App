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
    func buildFilterModule() -> FilterViewController
    //func buildSearchModule(router: RouterProtocol) -> UIViewController()

}

/// Object to manage building modules, injecting dependencies
final class ModuleBuilder: ModuleBuilderProtocol {
    
    func buildMainModule() -> MainViewController {
        let view = MainViewController()
        let APICaller = APICallerDefault()

        let presenter = MainPresenter(view: view, APICaller: APICaller)
        view.presenter = presenter
        
        return view
    }
    
    func buildListModule(categoryName: String, APIAttribute: String) -> ListViewController {
        let view = ListViewController()
        let APICaller = APICallerDefault()
        
        let presenter = ListPresenter(view: view, APICaller: APICaller, categoryName: categoryName, APIAttribute: APIAttribute)
        view.presenter = presenter
        
        return view
    }
    
    func buildDetailModule(businessID: String) -> DetailViewController {
        let view = DetailViewController()
        let APICaller = APICallerAlamofire()
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
    
    func buildFilterModule() -> FilterViewController {
        let view = FilterViewController()
        let presenter = FilterPresenter(view: view)
        view.presenter = presenter
        
        return view
    }
    
    
}
