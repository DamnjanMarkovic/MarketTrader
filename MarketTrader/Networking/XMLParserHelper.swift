//
//  XMLParser.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import Foundation

class XMLParserHelper: NSObject, XMLParserDelegate {
    
    var symbolList = [Symbol]()
    var symbol = Symbol()
    var quote = Quote()
    var foundCharacters = "";
    
    
    override init() {

    }

    func unwrapSymbolList(_ unwrappedData: Data, completition: @escaping ((_ symbolList: [Symbol]?)->())) {
    
        let parser = XMLParser(data: unwrappedData)
        parser.delegate = self
        parser.parse()
        completition(symbolList)
        
    }
    
    let simpleClosure:(String) -> (String) = { name in
        
        let greeting = "Hello, World! " + "Program"
        return greeting
    }

    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        let tempSymbol = Symbol();
        
        if elementName == "Quote" {
            
            let tempQuote = Quote();
                if let stringValue = attributeDict["last"] {
                    if let doubleValue = Double(stringValue) {
                        tempQuote.last = doubleValue;
                    }
                }
                if let stringValue = attributeDict["high"] {
                    if let doubleValue = Double(stringValue) {
                        tempQuote.high = doubleValue;
                    }
                }
                if let stringValue = attributeDict["low"] {
                    if let doubleValue = Double(stringValue) {
                        tempQuote.low = doubleValue;
                    }
                }
                if let stringValue = attributeDict["bid"] {
                    if let doubleValue = Double(stringValue) {
                        tempQuote.bid = doubleValue;
                    }
                }
                if let stringValue = attributeDict["ask"] {
                    if let doubleValue = Double(stringValue) {
                        tempQuote.ask = doubleValue;
                    }
                }
                if let stringValue = attributeDict["volume"] {
                    if let doubleValue = Double(stringValue) {
                        tempQuote.volume = doubleValue;
                    }
                }
            
                self.quote = tempQuote
        }
        
        
        if elementName == "Symbol" {
            
                if let value = attributeDict["id"] {
                    tempSymbol.id = value;
                }
                if let value = attributeDict["name"] {
                    tempSymbol.name = value;
                }
                if let value = attributeDict["tickerSymbol"] {
                    tempSymbol.tickerSymbol = value;
                }
                if let value = attributeDict["isin"] {
                    tempSymbol.isin = value;
                }
                if let value = attributeDict["currency"] {
                    tempSymbol.currency = value;
                }
                if let value = attributeDict["stockExchangeName"] {
                    tempSymbol.stockExchangeName = value;
                }
                if let value = attributeDict["decorativeName"] {
                    tempSymbol.decorativeName = value;
                }
            
                self.symbol = tempSymbol
            
        }
    }

    // 2
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        if elementName == "Quote" {
            let tempSymbol = Quote();
            tempSymbol.last = self.quote.last;
            tempSymbol.high = self.quote.high;
            tempSymbol.low = self.quote.low;
            tempSymbol.bid = self.quote.bid;
            tempSymbol.ask = self.quote.ask;
            tempSymbol.volume = self.quote.volume;
            
            self.symbol.quote = tempSymbol
        }
        
        
            if elementName == "Symbol" {

                self.symbolList.append(self.symbol);
            }
            self.foundCharacters = ""
        
    }

    // 3
    func parser(_ parser: XMLParser, foundCharacters string: String) {

        self.foundCharacters += string;
    }
    
    
    
}
