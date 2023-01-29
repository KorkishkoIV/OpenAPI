//
//  BaeCoordinator.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 23.01.2023.
//

import UIKit

class BaseCoordinator {
    var navigationController: UINavigationController?
    let fileService: FileService
    
    init (fileService: FileService) {
        self.fileService = fileService
    }
}
