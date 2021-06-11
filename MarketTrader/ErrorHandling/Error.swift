//
//  Error.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import Foundation

enum DataError: Error {
    case invalidResponse
    case invalidData
    case decodingError
    case serverError
}
