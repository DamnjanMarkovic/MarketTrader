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
