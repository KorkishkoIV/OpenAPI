//
//  SceneDelegate.swift
//  RealmTests
//
//  Created by Иван Коркишко on 01.12.2022.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene

        let appCoordinator = AppCoordinator()
        appCoordinator.start(window: window)
        
        window?.makeKeyAndVisible()
    }
}

