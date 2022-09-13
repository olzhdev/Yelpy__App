//
//  CoordinatorBuilder.swift
//  Yelpy
//
//  Created by MAC on 20.08.2022.
//

import Foundation
import UIKit

///For coordinators
protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    var moduleBuilder: ModuleBuilderProtocol? { get set }
    var flowCompletionHandler: (() -> ())? { get set }
    func startFirstView() -> UINavigationController?
}


final class CoordinatorBuilder {
    
    func setAppCoordinator(navController1: UINavigationController,
                           navController2: UINavigationController,
                           tabBarController: UITabBarController,
                           moduleBuilder: ModuleBuilderProtocol) -> AppCoordinator
    {
        AppCoordinator(navController1: navController1,
                       navController2: navController2,
                       tabBarController: tabBarController,
                       moduleBuilder: moduleBuilder)
    }
    
    func setMainCoordinator(navController: UINavigationController,
                            moduleBuilder: ModuleBuilderProtocol) -> MainCoordinator
    {
        MainCoordinator(navController: navController,
                        moduleBuilder: moduleBuilder)
    }
    
    func setFavoritesCoordinator(navController: UINavigationController,
                                 moduleBuilder: ModuleBuilderProtocol) -> FavoritesCoordinator
    {
        FavoritesCoordinator(navController: navController,
                             moduleBuilder: moduleBuilder)
    }

}
