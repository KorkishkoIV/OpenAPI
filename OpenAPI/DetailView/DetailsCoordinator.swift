//
//  DetailsCoordinator.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

protocol pDetailsCoordinator {
    func start(with model: Any)
}

final class DetailsCoordinator: BaseCoordinator, pDetailsCoordinator {
    func start(with model: Any) {
        
        let detailsVC = DetailsViewContorller()
        let detailsVM = DetailsViewModel()
        
        detailsVC.vm = detailsVM
        detailsVM.vc = detailsVC
        detailsVM.coordinator = self
        
        self.navigationController?.pushViewController(detailsVC, animated: true)      
        
    }
}
