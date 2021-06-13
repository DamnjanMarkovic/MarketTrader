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
    
    static let NEWS_CELL_IDENTIFIER = "NewssCellIdentifier"
    static let NEWS_FIRST_CELL_IDENTIFIER = "NewsFirstCellIdentifier"
    
    static let COLORDARKBLUE = UIColor(red: (21/255.0), green: (42/255.0), blue: (175/255.0), alpha: 1.0)
    
    static let SYMBOLMARKETLINK = "https://www.teletrader.rs/downloads/tt_symbol_list.xml"
    static let NEWSLINK = "https://www.teletrader.rs/downloads/tt_news_list.xml"
    static let IMAGESLINK = "https://cdn.ttweb.net/News/images/"
    
    static let USERNAME = "android_tt"
    static let PASSWORD = "Sk3M!@p9e"
    
    static let LOGINSTRING = "\(USERNAME):\(PASSWORD)"
    
    static let FONTSTYLE = UIFont.systemFont(ofSize: 20)
    static let FONTSTYLEHEADER = UIFont.systemFont(ofSize: 16)
    static let FONTCOLORHEADER = UIColor.black
    static let FONTSTYLESYMBOL = UIFont.systemFont(ofSize: 14)
    static let FONTSTYLESYMBOLCHANGE = UIFont.systemFont(ofSize: 14)
    
    static let IMAGEMARKETREFRESHBUTTON =  UIImage(systemName: "r.square")
    static let IMAGEMARKETSETTINGSBUTTON =  UIImage(systemName: "timer")
    static let TAB_SYMBOL =  UIImage(systemName: "bahtsign.circle")
    static let TAB_NEWS =  UIImage(systemName: "dot.radiowaves.forward")
    static let TAB_CV =  UIImage(systemName: "person")
    static let TAB_CV_CHECKED =  UIImage(systemName: "person.fill")
    static let TAB_NEWS_CHECKED =  UIImage(systemName: "antenna.radiowaves.left.and.right")
    static let TAB_SYMBOL_CHECKED =  UIImage(systemName: "bahtsign.circle.fill")
    
    
    static let SMALLIMAGESIZE = ".jpg?preset=w220_q40"
    static let MIDDLEIMAGESIZE = ".jpg?preset=w320_q50"
    static let BIGIMAGESIZE = ".jpg?preset=w800_q70"
    
    
    
}
