//
//  AppDelegate.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 23.01.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {        
        window = UIWindow()
        
        let appCoordinator = AppCoordinator()
        appCoordinator.start(window: window)
        
        window?.makeKeyAndVisible()
        
        return true
    }
}

