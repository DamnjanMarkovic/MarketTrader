//
//  SymbolDetailsViewModel.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

protocol SymbolDetailsDelegate {
    
    func returnMarketSymbolsProtocolFunc(symbolList: [Symbol])
    
}
class SymbolDetailsViewModel {
    
    var delegate: SymbolDetailsDelegate?
    

    
}
