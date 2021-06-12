//
//  DateTimeConverters.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

struct DateTimeConverters {
    
    static func getTimeInDateTimeFormat(timeAsString: String) -> Date {

        let formatter = DateFormatter()
        formatter.timeZone = NSTimeZone.local
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        return formatter.date(from: timeAsString)!
    }
    
    
}
