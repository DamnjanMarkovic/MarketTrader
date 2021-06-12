//
//  Symbol.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit


class Symbol : Codable{
    var id = ""
    var name = ""
    var tickerSymbol = ""
    var isin = ""
    var currency = ""
    var stockExchangeName = ""
    var decorativeName = ""
    var quote = Quote()
    

}


//struct Symbol : Decodable {
//    let id: String
//    let name: String
//    let tickerSymbol: String
//    let isin: String
//    let currency: String
//    let stockExchangeName: String
//    let decorativeName: String
//    let quote: Quote
//
//
//    init(id: String, name: String, tickerSymbol: String, isin: String, currency: String, stockExchangeName: String,
//         decorativeName: String, quote: Quote) {
//        self.id = id
//        self.name = name
//        self.tickerSymbol = tickerSymbol
//        self.isin = isin
//        self.currency = currency
//        self.stockExchangeName = stockExchangeName
//        self.decorativeName = decorativeName
//        self.quote = quote
//    }
