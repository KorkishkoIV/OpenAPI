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
        
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        
        let vc: UIViewController = {
            let vc = UIViewController.init()
            vc.navigationItem.title = "Main"
            vc.view.backgroundColor = .green
            return vc
        }()
        let nav = UINavigationController(rootViewController: vc)
        nav.navigationBar.isTranslucent = false
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        
        return true
    }
}

