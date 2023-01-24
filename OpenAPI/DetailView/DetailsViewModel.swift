//
//  DetailsViewModel.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

import Foundation

protocol pDetailsViewModel {
    
}

final class DetailsViewModel: pDetailsViewModel {
    weak var vc: pDetailsViewController?
    var coordinator: pDetailsCoordinator?
}
