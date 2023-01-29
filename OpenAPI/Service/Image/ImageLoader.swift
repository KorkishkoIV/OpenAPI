//
//  ImageLoader.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 29.01.2023.
//

import Foundation
import Alamofire

func fetchImageNetwork(url: URL, completion: @escaping(Result<Data,Error>) -> Void) {
    
    AF.request(url)
        .validate()
        .response(completionHandler:
                    { responce in
            debugPrint(responce)
            switch responce.result {
            case .success(let data):
                guard let unwrappedData = data else {
                    completion(.failure(NSError()))
                    return
                }
                completion(.success(unwrappedData))
                
            case .failure(let aError):
                completion(.failure(aError))
            }
        })
}
