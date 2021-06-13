//
//  SymbolViewCell.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class SymbolViewCell: UITableViewCell {

    var symbol = Symbol()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        // Configure the view for the selected state

    let nameSymbolLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 2
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.FONTCOLORHEADER
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = Constants.FONTSTYLESYMBOLCHANGE
        label.text = "Name ↓ ↑"
        label.layer.borderColor = UIColor.darkGray.cgColor
        return label
    }()
    let changePercentBidAskQuoteLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 2
        label.textColor = Constants.FONTCOLORHEADER
        label.backgroundColor = .clear
        label.text =  "Chg %"
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.FONTSTYLESYMBOLCHANGE
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.numberOfLines = 0
        label.textAlignment = .right
        return label
    }()
    let lastHighLowQuoteLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 2
        label.textColor = Constants.FONTCOLORHEADER
        label.backgroundColor = .clear
        label.text =  "Last"
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.FONTSTYLESYMBOLCHANGE
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.numberOfLines = 0
        return label
    }()

    
    func SetCellValues(symbol: Symbol, selectionFormatOriginal: Bool) {
        
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
    
    override func layoutSubviews() {
        
        nameSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        changePercentBidAskQuoteLabel.translatesAutoresizingMaskIntoConstraints = false
        lastHighLowQuoteLabel.translatesAutoresizingMaskIntoConstraints = false

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
