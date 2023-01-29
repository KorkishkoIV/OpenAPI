//
//  NewsAPILoader.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 29.01.2023.
//

import Foundation
import Alamofire

protocol PArticleLoader {
    
}

class NewsAPIRequestLoader: PArticleLoader {
    
    private static let endPoint = "https://newsapi.org/v2/everything"
    private static let apiKey = "ea7ae63db2f9498a832f78738197fdd6"
    private static let decoder: JSONDecoder = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        
        let jsonDecoder = JSONDecoder()
        jsonDecoder.dateDecodingStrategy = .formatted(dateFormatter)
        return jsonDecoder
    }()
    
    static func fetchArticles(_ completion: @escaping(Result<[Article], Error>) -> Void){
        let parameters = ["q":"ios"]
        let headers: HTTPHeaders = [.authorization(apiKey)]
        
        AF.request(endPoint, parameters: parameters, headers: headers)
            .validate()
            .responseDecodable(of: ArticlesResponce.self, decoder: decoder) { response in
                switch response.result {
                case .success(let articlesResponce):
                    guard let articles = articlesResponce.articles else {
                        completion(.failure(NSError()))
                        return
                    }
                    completion(.success(articles))
                case .failure(let aError):
                    completion(.failure(aError))
                }
            }
    }
}
