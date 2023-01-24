//
//  ListCoordinator.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 23.01.2023.
//

import Foundation
import UIKit

protocol pListCoordinator: AnyObject {
    func start(in window: UIWindow?)
    func openDetails (model: Any)
}

final class ListCoordinator: BaseCoordinator, pListCoordinator {
    func start(in window: UIWindow?) {
        
        let listVC = ListViewController()
        let listVM = ListViewModel()
        
        listVC.vm = listVM
        listVM.vc = listVC
        listVM.coordinator = self
        
        let navigationControoler = UINavigationController(rootViewController: listVC)
        self.navigationController = navigationControoler
        
        window?.rootViewController = self.navigationController
        window?.makeKeyAndVisible()
    }
    
    func openDetails(model: Any) {
        // ToDo - implement detailCoordinator.start()
    }
}
