//
//  FileService.swift
//  OpenAPI
//
//  Created by Иван Коркишко on 28.01.2023.
//

import Foundation

final class FileService {
    private let folderName: String
    
    init(folder: String) {
        self.folderName = folder
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded(){
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path
        else {
            return
        }
        if !FileManager.default.fileExists(atPath: path){
            do {
                try FileManager.default
                    .createDirectory(atPath: path,
                                     withIntermediateDirectories: true,
                                     attributes: nil)
            } catch let error  {
                debugPrint("Error creating files storage path: \(error)")
            }
        }
    }
    
    func getPathFor(name: String) -> URL? {
        guard let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .appendingPathComponent(name) else {
            debugPrint("Can't get path for: \(name)")
            return nil
        }
        return path
    }
    
    /// Save data in local directory with indicated name
    func saveToFile(data: Data?, name: String){
        guard let path = getPathFor(name: name),
              let data = data else {
            return
        }
        DispatchQueue.global(qos: .background).async {
            do{
                try data.write(to: path)
            }catch let error {
                debugPrint("Error writing data to path: \(path) (Error: \(error))")
            }
        }
    }
    
    /// Async lodaing data from file
    func asyncGetDataFromFile(name: String, completion: @escaping (Data?)->Void){
        guard let path = getPathFor(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            debugPrint("Error opening file named: \(name)")
            completion(nil)
            return
        }
        DispatchQueue.global(qos: .userInitiated).async {
            do{
                let data = try Data(contentsOf: path)
                completion (data)
            } catch let error {
                debugPrint("Error fetching data from path: \(path) (Error: \(error))")
                completion(nil)
            }
        }
    }
    
    /// Returns true if file exist in local directory, false otherwise
    func fileExist(name: String) -> Bool {
        guard let path = getPathFor(name: name) else {
            return false
        }
        return FileManager.default.fileExists(atPath: path.path)
    }
    
    /// Delete file from local directory
    func deleteFile(name: String) {
        guard let path = getPathFor(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            NSLog("[LocalFileManager] Error deleting file named: \(name)")
            return
        }
        DispatchQueue.global(qos: .background).async {
            do {
                try FileManager.default.removeItem(at: path)
            } catch let error {
                NSLog ("[LocalFileManager] Error deleting file with path: \(path) (Error: \(error))")
            }
        }
    }
    
    func deleteAll(){
        guard let path = getPathFor(name: ""),
              let filesNames = try? FileManager.default.contentsOfDirectory(atPath: path.path)
        else{
            return
        }
        DispatchQueue.global(qos: .utility).async {
            for fileName in filesNames{
                if let filePath = self.getPathFor(name: fileName){
                    try? FileManager.default.removeItem(at: filePath)
                }
            }
        }
    }  
}
