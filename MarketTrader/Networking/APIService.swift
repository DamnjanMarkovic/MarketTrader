//
//  APIService.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class APIService {
    
    
    typealias resultReceived<T> = (Result<T, Error>) -> Void
    
    
    func getMarketSymbols<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping resultReceived<T>) {


        guard let loginData = Constants.LOGINSTRING.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        
        if let error = error {
            completion(.failure(error))
        }

        guard let response = response as? HTTPURLResponse else {
            completion(.failure(DataError.invalidResponse))
            return
        }

        if 200 ... 299 ~= response.statusCode {
            if let unwrappedData = data {
                do {
                    completion(.success(unwrappedData as! T))
                }
            } else {
                completion(.failure(DataError.invalidData))
            }
        } else {
            completion(.failure(DataError.serverError))
        }
        }.resume()
    }
    
    
    
    func getNews<T: Decodable>(of type: T.Type, from url: URL, completion: @escaping resultReceived<T>) {


        guard let loginData = Constants.LOGINSTRING.data(using: String.Encoding.utf8) else {
            return
        }
        let base64LoginString = loginData.base64EncodedString()
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
        
        if let error = error {
            completion(.failure(error))
        }

        guard let response = response as? HTTPURLResponse else {
            completion(.failure(DataError.invalidResponse))
            return
        }

        if 200 ... 299 ~= response.statusCode {
            if let unwrappedData = data {
                do {
                    completion(.success(unwrappedData as! T))
                }
            } else {
                completion(.failure(DataError.invalidData))
            }
        } else {
            completion(.failure(DataError.serverError))
        }
        }.resume()
    }
    
    
//    static let cache = NSCache<NSString, UIImage>()
    
  
}



//extension UIImageView {
//
//    func loadImage(with urlString: String) {
//
//        // check if image exists in cache
//        if let cachedImage = imageCache[urlString] {
//            self.image = cachedImage
//            return
//
//        }
//
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//            if let error = error {
//                print("Failed to load image with error", error.localizedDescription)
//                return
//            }
//
//            // image data
//            guard let imageData = data else { return }
//
//            // set image using image data
//            let photoImage = UIImage(data: imageData)
//
//            // set key and value for image cache
//            self.imageCache[url.absoluteString] = photoImage
//
//            // set image
//            DispatchQueue.main.async {
//                self.image = photoImage
//            }
//
//        }.resume()
//
//    }
//}
//
//var imageCache = [String: UIImage]()
