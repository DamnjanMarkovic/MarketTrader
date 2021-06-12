//
//  Singletone.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import Foundation


final class Singletone: NSObject {
    
    static let sharedInstance = Singletone()
   
    private override init() { }
}

extension Singletone {
    
    static var symbolsList: [Symbol]?
    
    
}
