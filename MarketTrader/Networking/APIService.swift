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
    
}

