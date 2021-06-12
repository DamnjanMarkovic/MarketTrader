//
//  SymbolDetailsViewController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class SymbolDetailsViewController: UIViewController {


    var symbolSelected = Symbol()
    
    var idSymbolLabel = UILabel ()
    var nameSymbolLabel = UILabel ()
    var tickerSymbolSymbolLabel = UILabel ()
    var isinSymbolLabel = UILabel ()
    var currencySymbolLabel = UILabel ()
    var stockExchangeNameSymbolLabel = UILabel ()
    var decorativeNameSymbolLabel = UILabel ()
    var lastSymbolLabel = UILabel ()
    var highSymbolLabel = UILabel ()
    var lowSymbolSymbolLabel = UILabel ()
    var volumeSymbolLabel = UILabel ()
    var dateTimeSymbolLabel = UILabel ()
    var changeSymbolLabel = UILabel ()
    var changePercentSymbolLabel = UILabel ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
     
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = symbolSelected.name
        self.view.backgroundColor = .white
        createAllLabels()
        configureContents()
    }
    
    
    func CreateLabel(name: String) -> UILabel {
        let label = UILabel()
        label.layer.cornerRadius = 6
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.blue.cgColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.FONTCOLORHEADER
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = Constants.FONTSTYLEHEADER
        label.text = name
        label.layer.borderColor = UIColor.darkGray.cgColor
        return label
    }
    
    func createAllLabels() {
        idSymbolLabel = CreateLabel(name: "\tID:\t\(symbolSelected.id)")
        nameSymbolLabel = CreateLabel(name: "\tName:\t\(symbolSelected.name)")
        tickerSymbolSymbolLabel = CreateLabel(name: "\tTickerSymbol:\t\(symbolSelected.tickerSymbol)")
        isinSymbolLabel = CreateLabel(name: "\tIsin:\t\(symbolSelected.isin)")
        currencySymbolLabel = CreateLabel(name: "\tCurrency:\t\(symbolSelected.currency)")
        stockExchangeNameSymbolLabel = CreateLabel(name: "\tStockExchangeName:\t\(symbolSelected.stockExchangeName)")
        decorativeNameSymbolLabel = CreateLabel(name: "\tDecorativeName:\t\(symbolSelected.decorativeName)")
        lastSymbolLabel = CreateLabel(name: "\tLast:\t\(symbolSelected.quote.last)")
        highSymbolLabel = CreateLabel(name: "\tHigh:\t\(symbolSelected.quote.high)")
        lowSymbolSymbolLabel = CreateLabel(name: "\tLow:\t\(symbolSelected.quote.low)")
        volumeSymbolLabel = CreateLabel(name: "\tVolume:\t\(symbolSelected.quote.volume)")
        dateTimeSymbolLabel = CreateLabel(name: "\tDateTime:\t\(symbolSelected.quote.dateTime)")
        changeSymbolLabel = CreateLabel(name: "\tChange:\t\(symbolSelected.quote.change)")
        changePercentSymbolLabel = CreateLabel(name: "\tChangePercent:\t\(symbolSelected.quote.changePercent)")
        
        
        changeSymbolLabel.textColor = returnFontColor(value: symbolSelected.quote.change)
        changePercentSymbolLabel.textColor = returnFontColor(value: symbolSelected.quote.changePercent)
        
    }
    
    
    func returnFontColor(value: Double) -> UIColor {
        
        if value > 0 {
            return .green
        }
        else if ( value == 0) {
            return Constants.FONTCOLORHEADER
        }
        else {
            return .red
        }
    }
}


extension SymbolDetailsViewController {
    
    func configureContents() {
        
        idSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        nameSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        tickerSymbolSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        isinSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        currencySymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        stockExchangeNameSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        decorativeNameSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        lastSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        highSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        lowSymbolSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        volumeSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        dateTimeSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        changeSymbolLabel.translatesAutoresizingMaskIntoConstraints = false
        changePercentSymbolLabel.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(idSymbolLabel)
        self.view.addSubview(nameSymbolLabel)
        self.view.addSubview(tickerSymbolSymbolLabel)
        self.view.addSubview(isinSymbolLabel)
        self.view.addSubview(currencySymbolLabel)
        self.view.addSubview(stockExchangeNameSymbolLabel)
        self.view.addSubview(decorativeNameSymbolLabel)
        self.view.addSubview(lastSymbolLabel)
        self.view.addSubview(highSymbolLabel)
        self.view.addSubview(lowSymbolSymbolLabel)
        self.view.addSubview(volumeSymbolLabel)
        self.view.addSubview(dateTimeSymbolLabel)
        self.view.addSubview(changeSymbolLabel)
        self.view.addSubview(changePercentSymbolLabel)


        NSLayoutConstraint.activate([

            idSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            idSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            idSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            idSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            idSymbolLabel.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 70),

            nameSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            nameSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            nameSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            nameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            nameSymbolLabel.topAnchor.constraint(equalTo: idSymbolLabel.bottomAnchor, constant: 10),
            
            tickerSymbolSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            tickerSymbolSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            tickerSymbolSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            tickerSymbolSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            tickerSymbolSymbolLabel.topAnchor.constraint(equalTo: nameSymbolLabel.bottomAnchor, constant: 10),
            
            isinSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            isinSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            isinSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            isinSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            isinSymbolLabel.topAnchor.constraint(equalTo: tickerSymbolSymbolLabel.bottomAnchor, constant: 10),
            
            currencySymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            currencySymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            currencySymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            currencySymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            currencySymbolLabel.topAnchor.constraint(equalTo: isinSymbolLabel.bottomAnchor, constant: 10),
            
            stockExchangeNameSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            stockExchangeNameSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            stockExchangeNameSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            stockExchangeNameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            stockExchangeNameSymbolLabel.topAnchor.constraint(equalTo: currencySymbolLabel.bottomAnchor, constant: 10),
            
            decorativeNameSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            decorativeNameSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            decorativeNameSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            decorativeNameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            decorativeNameSymbolLabel.topAnchor.constraint(equalTo: stockExchangeNameSymbolLabel.bottomAnchor, constant: 10),
            
            lastSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            lastSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            lastSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            lastSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            lastSymbolLabel.topAnchor.constraint(equalTo: decorativeNameSymbolLabel.bottomAnchor, constant: 10),
            
            highSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            highSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            highSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            highSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            highSymbolLabel.topAnchor.constraint(equalTo: lastSymbolLabel.bottomAnchor, constant: 10),
            
            lowSymbolSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            lowSymbolSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            lowSymbolSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            lowSymbolSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            lowSymbolSymbolLabel.topAnchor.constraint(equalTo: highSymbolLabel.bottomAnchor, constant: 10),
            
            volumeSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            volumeSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            volumeSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            volumeSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            volumeSymbolLabel.topAnchor.constraint(equalTo: lowSymbolSymbolLabel.bottomAnchor, constant: 10),
            
            dateTimeSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            dateTimeSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            dateTimeSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            dateTimeSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            dateTimeSymbolLabel.topAnchor.constraint(equalTo: volumeSymbolLabel.bottomAnchor, constant: 10),
            
            changeSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            changeSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            changeSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            changeSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            changeSymbolLabel.topAnchor.constraint(equalTo: dateTimeSymbolLabel.bottomAnchor, constant: 10),
            
            changePercentSymbolLabel.leadingAnchor.constraint(equalTo: self.view.layoutMarginsGuide.leadingAnchor, constant: 10),
            changePercentSymbolLabel.widthAnchor.constraint(equalToConstant: self.view.frame.width),
            changePercentSymbolLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
            changePercentSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            changePercentSymbolLabel.topAnchor.constraint(equalTo: changeSymbolLabel.bottomAnchor, constant: 10),
            
        ])
    
    }

}
