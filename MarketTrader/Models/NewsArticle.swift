//
//  NewsArticle.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

struct NewsArticle {

    var headline = ""
    var imageID = ""
    
    init(details: [String: Any]) {
        headline = details["Headline"] as? String ?? ""
        imageID = details["ImageID"] as? String ?? ""
    }
    
    init() {

    }
    
}
