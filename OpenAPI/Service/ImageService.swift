//
//  ImageLoad.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 28.01.2023.
//

import Foundation
import UIKit

class ImageService {
    
    let fileService: FileService
    
    init(fileService: FileService) {
        self.fileService = fileService
    }
    
    func fetchImage(urlString: String?, completion: @escaping((UIImage?) -> Void)){
        guard let urlString = urlString,
            let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        let urlAsFileName = url.absoluteString.replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "https://", with: "")
        if fileService.fileExist(name: urlAsFileName) {
            fileService.asyncGetDataFromFile(name: urlAsFileName) { data in
                guard let data = data else {
                   completion(nil)
                    return
                }
                completion(UIImage(data: data))
            }
            return
        }
        
        fetchImageNetwork(url: url) { [unowned self] result in
            switch result {
            case .success(let imageData):
                completion(UIImage(data: imageData))
                fileService.saveToFile(data: imageData, name: urlAsFileName)
            case .failure(_):
                completion(nil)
            }
        }
    }
}

