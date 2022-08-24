//
//  SceneDelegate.swift
//  Yelpy
//
//  Created by MAC on 17.08.2022.
//

import UIKit
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    var tabBarController = UITabBarController()
    var navController1 = UINavigationController()
    var navController2 = UINavigationController()
    var moduleBuilder = ModuleBuilder()
    
    lazy var appCoordinator = CoordinatorBuilder().setAppCoordinator(
        navController1: navController1,
        navController2: navController2,
        tabBarController: tabBarController,
        moduleBuilder: moduleBuilder)


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }


        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        appCoordinator.start()
        
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

