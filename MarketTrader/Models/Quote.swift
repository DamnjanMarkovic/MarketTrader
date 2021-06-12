//
//  Quote.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

class Quote: Codable {
    var last = 0.0
    var high = 0.0
    var low = 0.0
    var bid = 0.0
    var ask = 0.0
    var volume = 0.0
    var dateTime = Date()
    var change = 0.0
    var changePercent = 0.0
    
}

//struct Quote: Decodable {
//    let last: Double
//    let high: Double
//    let low: Double
//    let bid: Double
//    let ask: Double
//    let volume: Double
//    let dateTime: String
//    let change: Double
//    let changePercent: Double
//    
//    
//    init(last: Double, high: Double, low: Double, bid: Double, ask: Double, volume: Double,
//         dateTime: String, change: Double, changePercent: Double) {
//        self.last = last
//        self.high = high
//        self.low = low
//        self.bid = bid
//        self.ask = ask
//        self.volume = volume
//        self.dateTime = dateTime
//        self.change = change
//        self.changePercent = changePercent
//    }
//    
//}
