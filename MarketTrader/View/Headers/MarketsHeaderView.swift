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
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)

        configureContents()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func SetFormating(selectionFormatingOriginal: Bool) {

        if selectionFormatingOriginal {
            changePercentBidAskQuoteLabel.text = "Chg %"
            lastHighLowQuoteLabel.text = "Last"
        }
        else {
            changePercentBidAskQuoteLabel.text = "Bid"
            lastHighLowQuoteLabel.text = "high"
        }
    }
    
    
    let nameSymbolButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Name ↓ ↑", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(red: 149/255, green: 204/255, blue: 244/255, alpha: 1)
        button.layer.cornerRadius = 5
        return button
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
    


    
    func configureContents() {
        
        nameSymbolButton.translatesAutoresizingMaskIntoConstraints = false
        changePercentBidAskQuoteLabel.translatesAutoresizingMaskIntoConstraints = false
        lastHighLowQuoteLabel.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(nameSymbolButton)
        contentView.addSubview(changePercentBidAskQuoteLabel)
        contentView.addSubview(lastHighLowQuoteLabel)


        NSLayoutConstraint.activate([

            nameSymbolButton.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            nameSymbolButton.widthAnchor.constraint(equalToConstant: 200),
            nameSymbolButton.heightAnchor.constraint(equalToConstant: 30),
            nameSymbolButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            
            
            changePercentBidAskQuoteLabel.heightAnchor.constraint(equalToConstant: 30),
            changePercentBidAskQuoteLabel.leadingAnchor.constraint(equalTo: nameSymbolButton.trailingAnchor,
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
