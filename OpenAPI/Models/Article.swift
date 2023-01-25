//
//  Article.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 25.01.2023.
//

import Foundation

struct Article: Codable {
    var source: String?
    var author: String?
    var title: String?
    var description: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?   
}

struct Source: Codable {
    var id: String?
    var name: String?
}
