//
//  MarketsHeaderView.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class MarketsHeaderView: UITableViewHeaderFooterView {

    var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    
    let nameSymbolLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 2
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.FONTCOLORHEADER
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = Constants.FONTSTYLEHEADER
        label.text = "Name ↓ ↑"
        label.layer.borderColor = UIColor.darkGray.cgColor
        return label
    }()
    let changePercentBidAskQuoteLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 2
        label.textColor = Constants.FONTCOLORHEADER
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.text =  "Chg %"
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.FONTSTYLEHEADER
        label.textAlignment = .center
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.numberOfLines = 0
        return label
    }()
    let lastHighLowQuoteLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 2
        label.textColor = Constants.FONTCOLORHEADER
        label.textAlignment = .center
        label.backgroundColor = .clear
        label.text =  "Last"
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.FONTSTYLEHEADER
        label.textAlignment = .center
        label.layer.borderColor = UIColor.darkGray.cgColor
        label.numberOfLines = 0
        return label
    }()
    

        override init(reuseIdentifier: String?) {
            super.init(reuseIdentifier: reuseIdentifier)
            configureContents()
        }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureContents() {
        
        nameSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        changePercentBidAskQuoteLabel.translatesAutoresizingMaskIntoConstraints = false
        lastHighLowQuoteLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameSymbolLabel)
        contentView.addSubview(changePercentBidAskQuoteLabel)
        contentView.addSubview(lastHighLowQuoteLabel)


        NSLayoutConstraint.activate([

            nameSymbolLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameSymbolLabel.widthAnchor.constraint(equalToConstant: 200),
            nameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            nameSymbolLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            
            
            changePercentBidAskQuoteLabel.heightAnchor.constraint(equalToConstant: 30),
            changePercentBidAskQuoteLabel.leadingAnchor.constraint(equalTo: nameSymbolLabel.trailingAnchor,
               constant: 10),
            changePercentBidAskQuoteLabel.widthAnchor.constraint(equalToConstant: 50),
//            changePercentBidAskQuoteLabel.trailingAnchor.constraint(equalTo:
//               contentView.layoutMarginsGuide.trailingAnchor),
            changePercentBidAskQuoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            
            
            lastHighLowQuoteLabel.heightAnchor.constraint(equalToConstant: 30),
            lastHighLowQuoteLabel.leadingAnchor.constraint(equalTo: changePercentBidAskQuoteLabel.trailingAnchor,
               constant: 10),
            lastHighLowQuoteLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
//            lastHighLowQuoteLabel.widthAnchor.constraint(equalToConstant: 25),
//            lastHighLowQuoteLabel.trailingAnchor.constraint(equalTo:
//               contentView.layoutMarginsGuide.trailingAnchor),
            lastHighLowQuoteLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    
    }
}
