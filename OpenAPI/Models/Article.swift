//
//  Article.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 25.01.2023.
//

import Foundation

struct Article: Codable {
    var source: ArticleSource?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: Date?
    var content: String?   
}

struct ArticleSource: Codable {
    var id: String?
    var name: String?
}
