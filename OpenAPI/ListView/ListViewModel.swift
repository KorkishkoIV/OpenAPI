//
//  ListViewModel.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

import Foundation

protocol pListVM {
    func itemsCount() -> Int
    func item(index: Int) -> Any
    func fetchItems()
    func showDetailsForItemAtindex(index: Int)
}

class ListViewModel: pListVM {
    weak var vc: pListViewController?
    var coordinator: pListCoordinator?
    
    private var items: [Any] = []
    
    func itemsCount() -> Int {
        return items.count
    }
    
    func item(index: Int) -> Any {
        items[index]
    }
    
    func fetchItems() {
        
    }
    
    func showDetailsForItemAtindex(index: Int) {
        
    }
    
}
