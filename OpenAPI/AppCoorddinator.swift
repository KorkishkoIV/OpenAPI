//
//  AppCoorddinator.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 23.01.2023.
//

import Foundation
import UIKit

final class AppCoordinator {
    
    private var nav: UINavigationController?
    
    func start(window: UIWindow?) {
        let listCoordinator = ListCoordinator()
        listCoordinator.start(in: window)
    }
}
