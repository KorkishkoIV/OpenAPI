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
    func reloadItems()
    func showDetailsForItemAtindex(index: Int)
}

class ListViewModel: pListVM {
    weak var vc: pListViewController?
    var coordinator: pListCoordinator?
    
    private let articlesService: PArticlesService
    private var items: [Article] = []
    
    init(service: PArticlesService) {
        self.articlesService = service
    }
    
    func itemsCount() -> Int {
        return items.count
    }
    
    func item(index: Int) -> Any {
        items[index]
    }
    
    func fetchItems() {
        articlesService.fetchArticles(completion: handler)
    }
    
    func reloadItems() {
        articlesService.reloadArticles(completion: handler)
    }
    
    private func handler(loadedArticles: [Article]?) {
        guard let articles = loadedArticles else {
            return
        }
        items = articles
        DispatchQueue.main.async {
            self.vc?.reload()
        }
    }
    
    func showDetailsForItemAtindex(index: Int) {
        coordinator?.openDetails(model: items[index])
    }
}
