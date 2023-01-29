//
//  ArticlesService.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 29.01.2023.
//

import Foundation

protocol PArticlesService {
    func fetchArticles(completion: @escaping([Article]?) -> Void)
    func reloadArticles (completion: @escaping([Article]?) -> Void)
}

class ArticlesService: PArticlesService {
    private let fileService: FileService
    private let fileName = "Articles.json"

    init (fileService: FileService) {
        self.fileService = fileService
    }
    
    func fetchArticles(completion: @escaping([Article]?) -> Void) {
        if fileService.fileExist(name: fileName) {
            loadArticlesFromFile(completion: completion)
        } else {
            loadArticlesFromAPI { [unowned self] articles in
                guard let articles = articles else {
                    completion(nil)
                    return
                }
                completion(articles)
                saveArticlesToFile(articles: articles)
            }
        }
        
    }
    
    func reloadArticles(completion: @escaping([Article]?) -> Void) {
        loadArticlesFromAPI {[unowned self] articles in
            completion(articles)
            guard let articles = articles else {
                return
            }
            fileService.deleteFile(name: fileName)
            saveArticlesToFile(articles: articles)
        }
    }
    
    private func loadArticlesFromFile (completion: @escaping ([Article]?) -> Void){
        fileService.asyncGetDataFromFile(name: fileName) { data in
            guard let articlesData = data,
                  let articles = try? JSONDecoder().decode([Article].self, from: articlesData)
            else {
                completion(nil)
                return
            }
            completion(articles)
        }
    }
    
    private func loadArticlesFromAPI (completion: @escaping ([Article]?) -> Void) {
        NewsAPIRequestLoader.fetchArticles { result in
            switch result {
            case .success(let articles):
                completion(articles)
            case .failure(_):
                completion(nil)
            }
        }
    }
    
    private func saveArticlesToFile(articles: [Article]) {
        guard let data = try? JSONEncoder().encode(articles) else {
            return
        }
        fileService.saveToFile(data: data, name: fileName)
    }
}
