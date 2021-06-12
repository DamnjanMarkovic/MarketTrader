//
//  Constants.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

struct Constants {
    
    static let MARKET_CELL_IDENTIFIER = "MarketCellIdentifier"
    static let MARKET_HEADER_IDENTIFIER = "MarketHeaderIdentifier"
    
    static let SYMBOLDETAILS_CELL_IDENTIFIER = "SymbolDetailsCellIdentifier"
    
    static let COLORDARKBLUE = UIColor(red: (21/255.0), green: (42/255.0), blue: (175/255.0), alpha: 1.0)
    
    static let SYMBOLMARKETLINK = "https://www.teletrader.rs/downloads/tt_symbol_list.xml"
    
    static let USERNAME = "android_tt"
    static let PASSWORD = "Sk3M!@p9e"
    
    static let LOGINSTRING = "\(USERNAME):\(PASSWORD)"
    
    static let FONTSTYLE = UIFont.systemFont(ofSize: 20)
    static let FONTSTYLEHEADER = UIFont.systemFont(ofSize: 18)
    static let FONTCOLORHEADER = UIColor.black
    
    static let IMAGEMARKETREFRESHBUTTON =  UIImage(systemName: "iphone.radiowaves.left.and.right")
    static let IMAGEMARKETSETTINGSBUTTON =  UIImage(systemName: "plus.message") 
    
    
}
