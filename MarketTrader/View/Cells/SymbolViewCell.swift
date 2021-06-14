//
//  SymbolViewCell.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class SymbolViewCell: UITableViewCell {

    var symbol = Symbol()
    var selectionFormatOriginal = false
    
    var nameSymbolLabel = UILabel ()
    var changePercentBidAskQuoteLabel = UILabel ()
    var lastHighLowQuoteLabel = UILabel ()
    var previousChangePercentValue = 0.00
    var previousLastValue = 0.00
    var previousBidValue = 0.00
    var previousHighValue = 0.00
    
    
    private var timerClearingLabelBackgrounds: Timer?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        CreateLabels()
        
        ConfigureUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func SetCellValues(symbol: Symbol, selectionFormatOriginal: Bool) {
        
        
        self.selectionFormatOriginal = selectionFormatOriginal
        self.symbol = symbol
        
        let changePercent = symbol.quote.changePercent
        let last = symbol.quote.last
        let bid = symbol.quote.bid
        let high = symbol.quote.high
        
        if selectionFormatOriginal {
            
            if changePercent > 0 {
                changePercentBidAskQuoteLabel.textColor = .green
            }
            else if (changePercent < 0) {
                changePercentBidAskQuoteLabel.textColor = .red
            }
            
            nameSymbolLabel.text = symbol.name
            changePercentBidAskQuoteLabel.text =   "\(String(format:"%.2f", changePercent))%"
            lastHighLowQuoteLabel.text = "\(String(format:"%.2f",last))"
            changePercentBidAskQuoteLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousChangePercentValue, newValue: changePercent)
            lastHighLowQuoteLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousLastValue, newValue: last)
            
        }
        
        else {
            nameSymbolLabel.text = symbol.name
            changePercentBidAskQuoteLabel.text = "\(String(format:"%.2f", bid))"
            lastHighLowQuoteLabel.text = "\(String(format:"%.2f", high))"
            changePercentBidAskQuoteLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousBidValue, newValue: bid)
            lastHighLowQuoteLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousHighValue, newValue: last)
            
        }
        
        previousChangePercentValue = changePercent
        previousLastValue = last
        previousBidValue = bid
        previousHighValue = high
        
        timerClearingLabelBackgrounds = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(SymbolViewCell.ClearingLabelBackgrounds), userInfo: nil, repeats: false)
        
        
    }
    
    @objc func ClearingLabelBackgrounds() {
        
        changePercentBidAskQuoteLabel.backgroundColor = .clear
        lastHighLowQuoteLabel.backgroundColor = .clear
        
    }

}


extension SymbolViewCell {
    
    func CreateLabels() {
        
        nameSymbolLabel = CreateLabel()
        
        changePercentBidAskQuoteLabel = CreateLabel()
        changePercentBidAskQuoteLabel.textAlignment = .right
        
        lastHighLowQuoteLabel = CreateLabel()
        lastHighLowQuoteLabel.textAlignment = .right
    }
    
    func CreateLabel() -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.FONTCOLORHEADER
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = Constants.FONTSTYLESYMBOL
        label.layer.borderColor = UIColor.darkGray.cgColor
        return label
    }
    
    func ConfigureUI() {
        
        contentView.addSubview(nameSymbolLabel)
        contentView.addSubview(changePercentBidAskQuoteLabel)
        contentView.addSubview(lastHighLowQuoteLabel)


        NSLayoutConstraint.activate([

            nameSymbolLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            nameSymbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            changePercentBidAskQuoteLabel.heightAnchor.constraint(equalToConstant: 30),
            changePercentBidAskQuoteLabel.leadingAnchor.constraint(equalTo: nameSymbolLabel.trailingAnchor,
               constant: 5),
            changePercentBidAskQuoteLabel.widthAnchor.constraint(equalToConstant: 70),
            changePercentBidAskQuoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            
            lastHighLowQuoteLabel.heightAnchor.constraint(equalToConstant: 30),
            lastHighLowQuoteLabel.leadingAnchor.constraint(equalTo: changePercentBidAskQuoteLabel.trailingAnchor,
               constant: 5),
            lastHighLowQuoteLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            lastHighLowQuoteLabel.widthAnchor.constraint(equalToConstant: 70),
            lastHighLowQuoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    

}
