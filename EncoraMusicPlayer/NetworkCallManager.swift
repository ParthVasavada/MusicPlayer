//
//  NetworkCallManager.swift
//  EncoraMusicPlayer
//
//  Created by Parth Vasavada on 10/04/21.
//

import Foundation
import UIKit
class NetworkCallManager: NSObject {
        
    typealias responseHandler = (Result<String, AppConnectionStatus>) -> Void
    typealias imageHandler = (Result<UIImage, AppConnectionStatus>) -> Void

    /* This function is designed to download songs from XML service file.
     
     - Parameters:
     - url: server URL to fetch data.
     - completion: called with the downloaded songs.
     */
    
    func getSongsList(for url: URL, completion: @escaping responseHandler) {

        print("========== Downloading songs from server.===============")

        URLSession.shared.dataTask(with: url) { data, response, error in

            if let _ = error  {
                print("Error downloading songs.")
                completion(.failure(.unknown))
            }
            
            if let xmlData = data,
               let response = response as? HTTPURLResponse, AppConnectionStatus.status(for: response.statusCode) == AppConnectionStatus.success {
                if let xmlString = String(data: xmlData, encoding: .utf8) {
                    completion(.success(xmlString))
                } else {
                    completion(.failure(.invalidResponse))
                }
            } else {
                completion(.failure(.invalidResponse))
            }
            
        }.resume()
        
    }
    
    /* This function is designed to download image data spec in the XML file
     
     - Parameters:
     - imageURL: The image URL string
     - completion: called with the downloaded image.
     */
    func downloadImage(for imageURL: URL, completion: @escaping imageHandler ) {
        
        URLSession.shared.dataTask(with: imageURL) { data, response, responseError in
            
            if let _ = responseError  {
                print("Error downloading song image.")
                completion(.failure(.unknown))
            }
            
            guard let imageData = data,
                  let response = response as? HTTPURLResponse, AppConnectionStatus.status(for: response.statusCode) == AppConnectionStatus.success,
                  let image = UIImage(data: imageData) else {
                completion(.failure(.invalidResponse))
                return
            }
            
            completion(.success(image))
            
        }.resume()
        
    }
}
