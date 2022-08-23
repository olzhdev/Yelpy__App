//
//  AppCoordinator.swift
//  Yelpy
//
//  Created by MAC on 20.08.2022.
//

import Foundation
import UIKit

protocol AppCoordinatorMain {
    var tabBarController: UITabBarController? { get set }
    var navController1: UINavigationController? { get set }
    var navController2: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
}

protocol AppCoordinatorProtocol: AppCoordinatorMain {
    func start()
}

class AppCoordinator: AppCoordinatorProtocol {
    
    var tabBarController: UITabBarController?
    var navController1: UINavigationController?
    var navController2: UINavigationController?
    var moduleBuilder: ModuleBuilderProtocol?
    
    init(navController1: UINavigationController, navController2: UINavigationController, tabBarController: UITabBarController, moduleBuilder: ModuleBuilderProtocol)
    {
        self.navController1 = navController1
        self.navController2 = navController2
        self.tabBarController = tabBarController
        self.moduleBuilder = moduleBuilder
    }
    
    func start() {
        if let tabBarController = tabBarController {
            tabBarController.viewControllers = [mainFlow()!]
        }
    }
    
    private func mainFlow() -> UINavigationController? {
        guard let navController1 = navController1,
              let moduleBuilder = moduleBuilder else { return nil }
    
        let mainCoordinator = CoordinatorBuilder().setMainCoordinator(navController: navController1, moduleBuilder: moduleBuilder)
        
        mainCoordinator.startFirstView()?.tabBarItem = UITabBarItem(title: "Explore", image: UIImage(systemName: "sparkles"), selectedImage: UIImage(systemName: "sparkles"))

        return mainCoordinator.startFirstView()
    }
}
