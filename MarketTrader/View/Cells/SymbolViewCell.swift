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
    
    var refreshingInterval = 1
    
    private var timer: Timer?
    private var timerClearingLabelBackgrounds: Timer?
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        CreateLabels()
        
        ConfigureUI()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func SetCellValues(symbol: Symbol, selectionFormatOriginal: Bool, refreshingInterval: Int, shouldRefresh: Bool) {
        
        self.refreshingInterval = refreshingInterval
        self.selectionFormatOriginal = selectionFormatOriginal
        self.symbol = symbol
        
        if shouldRefresh {
            
            RefreshValues()
            
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshingInterval), target: self, selector: #selector(SymbolViewCell.RefreshValues), userInfo: nil, repeats: true)
            


        }
        
        else {

            if selectionFormatOriginal {
                
                if symbol.quote.changePercent > 0 {
                    changePercentBidAskQuoteLabel.textColor = .green
                }
                else if (symbol.quote.changePercent == 0) {
                }
                else {
                    changePercentBidAskQuoteLabel.textColor = .red
                }
                
                nameSymbolLabel.text = symbol.name
                changePercentBidAskQuoteLabel.text =   "\(String(format:"%.2f", symbol.quote.changePercent))%"
                lastHighLowQuoteLabel.text = "\(String(format:"%.2f",symbol.quote.last))"
            }
            
            else {
                nameSymbolLabel.text = symbol.name
                changePercentBidAskQuoteLabel.text = "\(String(format:"%.2f",symbol.quote.bid))"
                lastHighLowQuoteLabel.text = "\(String(format:"%.2f",symbol.quote.high))"
            }
        }
        
    }
    
    @objc func ClearingLabelBackgrounds() {
        
        changePercentBidAskQuoteLabel.backgroundColor = .clear
        
        lastHighLowQuoteLabel.backgroundColor = .clear
    }
    
    
    @objc func RefreshValues() {
        
        timerClearingLabelBackgrounds = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(SymbolViewCell.ClearingLabelBackgrounds), userInfo: nil, repeats: false)

        let changePercent = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.changePercent)
        let last = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.last)
        let bid = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.bid)
        let high = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.high)
        
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

    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    override func prepareForReuse() {
        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
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
