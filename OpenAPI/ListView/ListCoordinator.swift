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
        let listVM = ListVMStub()//ListViewModel()
        
        listVC.vm = listVM
        listVM.vc = listVC
        listVM.coordinator = self
        
        let navController = UINavigationController(rootViewController: listVC)
        navigationController = navController
        window?.rootViewController = navigationController
    }
    
    func openDetails(model: Any) {
        let detailsCoordinator = DetailsCoordinator()
        detailsCoordinator.navigationController = self.navigationController
        guard let article = model as? Article else {
            return
        }
        detailsCoordinator.start(with: article)
    }
}
