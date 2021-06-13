//
//  RefreshHelpers.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 14.6.21..
//

import UIKit

struct RefreshHelpers {

    static func  GetChangedValueDouble(value: Double) -> Double {
    
        let valueTwoDecimals = Double(String(format:"%.2f", value))
        
        let lowerValue = valueTwoDecimals! + (valueTwoDecimals! * -20 / 100)
        let upperValue = valueTwoDecimals! + (valueTwoDecimals! * 20 / 100)
        
        if (upperValue > lowerValue) {
            return Double.random(in: lowerValue...upperValue)
        }
        else {
            return valueTwoDecimals!
        }
    }

    static func GetLabelBackgroundColor(previosValue: Double, newValue: Double) -> UIColor {
        if ((newValue - previosValue) >= 0) {
            return UIColor.blue
        }
        else if ((newValue - previosValue) < 0 ) {
            return UIColor.systemPink
        }
        else {
            return UIColor.clear
        }
    }
}
