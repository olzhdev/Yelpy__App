//
//  Router.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

/*
import Foundation
import UIKit

protocol RouterMain {
    var navController1: UINavigationController? {get set}
    var navController2: UINavigationController? {get set}
    var navController3: UINavigationController? {get set}
    var tabBar: UITabBarController? {get set}
    var moduleBuilder: ModuleBuilderProtocol? {get set}
}

protocol RouterProtocol: RouterMain {
    func setTabBarViewControllers()
    func setMainView() -> UINavigationController?
    func setFavoritesView() -> UINavigationController?
}

class Router: RouterProtocol {
    
    var navController1: UINavigationController?
    var navController2: UINavigationController?
    var navController3: UINavigationController?
    var tabBar: UITabBarController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navController1: UINavigationController,
         navController2: UINavigationController,
         navController3: UINavigationController,
         tabBar: UITabBarController,
         moduleBuilder: ModuleBuilderProtocol)
    {
        self.navController1 = navController1
        self.navController2 = navController2
        self.navController3 = navController3
        self.tabBar = tabBar
        self.moduleBuilder = moduleBuilder
    }
        
    
    func setTabBarViewControllers() {
        if let tabBar = tabBar {
            tabBar.viewControllers = [setMainView()!, setFavoritesView()!]
        }
    }
    
    func setMainView() -> UINavigationController? {
        if let navController1 = navController1 {
            guard let mainVC = moduleBuilder?.buildMainModule(router: self) else { return nil }
            mainVC.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "sparkles"), selectedImage: UIImage(systemName: "sparkles"))
            
            navController1.viewControllers = [mainVC]
        }
        return navController1
    }
    
    func setFavoritesView() -> UINavigationController? {
        if let navController2 = navController2 {
            guard let favoritesVC = moduleBuilder?.buildFavoritesModule(router: self) else { return nil}
            favoritesVC.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.rectangle.fill"), selectedImage: UIImage(systemName: "heart.rectangle.fill"))
            
            navController2.viewControllers = [favoritesVC]
        }
        return navController2
    }

}

*/
