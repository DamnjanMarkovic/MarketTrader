//
//  SymbolHeaderView.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//


import UIKit

class SymbolHeaderView: UITableViewHeaderFooterView {

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
            lastHighLowQuoteLabel.text = "High"
        }
    }
    
    
    let nameSymbolButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Name ↓ ↑", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 5
        return button
    }()
    
    
    
    let changePercentBidAskQuoteLabel: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = 2
        label.textColor = Constants.FONTCOLORHEADER
        label.textAlignment = .right
        label.backgroundColor = .clear
        label.text =  "Chg %"
        label.lineBreakMode = .byWordWrapping
        label.font = Constants.FONTSTYLEHEADER
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
            nameSymbolButton.heightAnchor.constraint(equalToConstant: 30),
            nameSymbolButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            
            
            changePercentBidAskQuoteLabel.heightAnchor.constraint(equalToConstant: 30),
            changePercentBidAskQuoteLabel.leadingAnchor.constraint(equalTo: nameSymbolButton.trailingAnchor,
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
