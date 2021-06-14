//
//  SymbolDetailsViewModel.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

protocol SymbolDetailsDelegate {
    
    func UpdateSymbol(symbol: Symbol)
    
}


class SymbolDetailsViewModel: NSObject {
    
    var symbol = Symbol()
    private var timer: Timer?
    var refreshingInterval = 1
    var delegate: SymbolDetailsDelegate?
    
    override init() {
        super.init()

    }

    
    func HandleSymbolRefreshing(symbol: Symbol, shouldRefresh: Bool, refreshingInterval: Int) {
        
        if shouldRefresh {
            self.symbol = symbol
            
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshingInterval), target: self, selector: #selector(RefreshValues), userInfo: nil, repeats: true)
        }
        
        else {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }

    }
    
    @objc func RefreshValues() {

        symbol.quote.changePercent = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.changePercent)
        symbol.quote.last = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.last)
        symbol.quote.bid = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.bid)
        symbol.quote.high = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.high)
  
        delegate?.UpdateSymbol(symbol: symbol)
        
  }
    
}
