//
//  DetailsCoordinator.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

protocol pDetailsCoordinator {
    func start(with model: Article)
}

final class DetailsCoordinator: BaseCoordinator, pDetailsCoordinator {
    func start(with model: Article) {
        
        let imageProvider = ImageService(fileService: fileService)
        
        let detailsVC = DetailsViewContorller()
        let detailsVM = DetailsViewModel(article: model, imageLoader: imageProvider)
        
        detailsVC.vm = detailsVM
        detailsVM.vc = detailsVC
        detailsVM.coordinator = self
        
        self.navigationController?.pushViewController(detailsVC, animated: true)      
        
    }
}
