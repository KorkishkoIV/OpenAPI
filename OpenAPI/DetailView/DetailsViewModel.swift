//
//  DetailsViewModel.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 24.01.2023.
//

import Foundation

protocol pDetailsViewModel {
    func title() -> String
    func authorString() -> String
    func publishDateString() -> String
    func presentationContent() -> String
    func fetchArticleImage()
}

final class DetailsViewModel: pDetailsViewModel {
    weak var vc: pDetailsViewController?
    var coordinator: pDetailsCoordinator?
    
    private var article: Article
    private let imageProvider: ImageService
    
    init(article: Article, imageLoader: ImageService) {
        self.article = article
        self.imageProvider = imageLoader
    }
    
    func title() -> String {
        article.title ?? ""
    }
    
    func authorString() -> String {
        guard let author = article.author else {
            return "Unknown"
        }
        return "by " + author
    }
    
    func publishDateString() -> String {
        let dateFormatter: DateFormatter = {
            let df = DateFormatter()
            df.dateFormat = "EEE, dd.MM.YYYY"
            return df
        }()
        
        guard let publishDate = article.publishedAt else {
            return ""
        }
        
        return dateFormatter.string(from: publishDate)
    }
    
    func presentationContent() -> String {
        guard let content = article.content else {
            return ""
        }
        return "\t" + content.replacingOccurrences(of: #"\[\+\d* chars\]"#,
                                     with: "",
                                     options: [.regularExpression],
                                            range: content.range(of: content))
    }
    
    func fetchArticleImage() {
        imageProvider.fetchImage(urlString: article.urlToImage) { image in
            guard let image = image else {
                return
            }

            DispatchQueue.main.async { [weak self] in
                self?.vc?.setArticleImage(image)
            }
        }
    }
    
}
