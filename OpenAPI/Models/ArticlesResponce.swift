//
//  ArticlesResponce.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 25.01.2023.
//

import Foundation

struct ArticlesResponce: Decodable {
    var status: String
    var totalResults: Int?
    var articles: [Article]?
}
