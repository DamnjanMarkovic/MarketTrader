//
//  SymbolDetailsViewController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

extension SymbolDetailsViewController: SymbolDetailsDelegate {
    
    func UpdateSymbol(symbol: Symbol) {
        self.symbol = symbol
    }

}

class SymbolDetailsViewController: UIViewController {
    

    var symbol = Symbol() {
        didSet {
            SetLabelValues(symbol: symbol)
        }
    }
    var symbolDetailsViewModel: SymbolDetailsViewModel = SymbolDetailsViewModel()
    
    var previousChangePercentValue = 0.00
    var previousChange = 0.00
    var previousBid = 0.00
    var previousHigh = 0.00
    
    private var timerClearingLabelBackgrounds: Timer?
    
    var shouldRefresh = false {
        didSet {
            symbolDetailsViewModel.HandleSymbolRefreshing(symbol: symbol, shouldRefresh: shouldRefresh, refreshingInterval: refreshingInterval)
        }
    }
    var refreshingInterval = 1
    
    
    var scrollViewer = UIScrollView()
    var idSymbolLabel = UILabel ()
    var nameSymbolLabel = UILabel ()
    var tickerSymbolSymbolLabel = UILabel ()
    var isinSymbolLabel = UILabel ()
    var currencySymbolLabel = UILabel ()
    var stockExchangeNameSymbolLabel = UILabel ()
    var decorativeNameSymbolLabel = UILabel ()
    var bidSymbolLabel = UILabel ()
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
        self.title = symbol.name
        self.view.backgroundColor = .white
        symbolDetailsViewModel.delegate = self
        createAllLabels()
        configureContents()
        SetLabelValues(symbol: symbol)

    }
    
    func SetLabelValues(symbol: Symbol) {
        
        timerClearingLabelBackgrounds = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(SymbolDetailsViewController.ClearingLabelBackgrounds), userInfo: nil, repeats: false)
        
        let changePercent = symbol.quote.changePercent
        let change = symbol.quote.change
        let bid = symbol.quote.bid
        let high = symbol.quote.high

        if changePercent > 0 {
            changeSymbolLabel.textColor = .green
            changePercentSymbolLabel.textColor = .green
            bidSymbolLabel.textColor = .green
            highSymbolLabel.textColor = .green
        }
        else if (changePercent < 0) {
            changeSymbolLabel.textColor = .red
            changePercentSymbolLabel.textColor = .red
            bidSymbolLabel.textColor = .red
            highSymbolLabel.textColor = .red
        }
        
        nameSymbolLabel.text = symbol.name
        
        changePercentSymbolLabel.text = "  ChangePercent:\t\(String(format:"%.2f",changePercent))"
        changeSymbolLabel.text =   "  Change:\t\(String(format:"%.2f", change))%"
        bidSymbolLabel.text =   "  Bid:\t\(String(format:"%.2f", bid))%"
        highSymbolLabel.text =   "  High:\t\(String(format:"%.2f", high))%"
        
        changeSymbolLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousChange, newValue: change)
        changePercentSymbolLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousChangePercentValue, newValue: changePercent)
        bidSymbolLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousBid, newValue: bid)
        highSymbolLabel.backgroundColor = RefreshHelpers.GetLabelBackgroundColor(previosValue: previousHigh, newValue: high)
        
        
        previousChangePercentValue = changePercent
        previousChange = change
        previousBid = bid
        previousHigh = high
        
    }
    
    @objc func ClearingLabelBackgrounds() {
        
        changeSymbolLabel.backgroundColor = .clear
        changePercentSymbolLabel.backgroundColor = .clear
        bidSymbolLabel.backgroundColor = .clear
        highSymbolLabel.backgroundColor = .clear
        
    }
}


extension SymbolDetailsViewController {
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }
    
    func CreateLabel(name: String) -> UILabel {
        let label = UILabel()
        label.layer.cornerRadius = 4
        label.layer.borderWidth = 1
        label.layer.borderColor = UIColor.gray.cgColor
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.FONTCOLORHEADER
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = Constants.FONTSTYLEHEADER
        label.text = name
        label.layer.borderColor = UIColor.darkGray.cgColor
        return label
    }
    
    func createAllLabels() {
        idSymbolLabel = CreateLabel(name: "  ID:\t\(symbol.id)")
        tickerSymbolSymbolLabel = CreateLabel(name: "  TickerSymbol:\t\(symbol.tickerSymbol)")
        isinSymbolLabel = CreateLabel(name: "  Isin:\t\(symbol.isin)")
        currencySymbolLabel = CreateLabel(name: "  Currency:\t\(symbol.currency)")
        stockExchangeNameSymbolLabel = CreateLabel(name: "  StockExchangeName:\t\(symbol.stockExchangeName)")
        decorativeNameSymbolLabel = CreateLabel(name: "  DecorativeName:\t\(symbol.decorativeName)")
        lastSymbolLabel = CreateLabel(name: "  Last:\t\(symbol.quote.last)")
        highSymbolLabel = CreateLabel(name: "  High:\t\(symbol.quote.high)")
        bidSymbolLabel = CreateLabel(name: "  Bid:\t\(symbol.quote.bid)")
        lowSymbolSymbolLabel = CreateLabel(name: "  Low:\t\(symbol.quote.low)")
        volumeSymbolLabel = CreateLabel(name: "  Volume:\t\(symbol.quote.volume)")
        dateTimeSymbolLabel = CreateLabel(name: "  DateTime:\t\(symbol.quote.dateTime)")
        changeSymbolLabel = CreateLabel(name: "  Change:\t\(symbol.quote.change)")
        changePercentSymbolLabel = CreateLabel(name: "  ChangePercent:\t\(symbol.quote.changePercent)")
        
    }

    
    func configureContents() {
        scrollViewer.translatesAutoresizingMaskIntoConstraints = false
        scrollViewer.bounds = view.bounds
        self.view.addSubview(scrollViewer)
        let widthLabel = view.frame.width - 30

        scrollViewer.addSubview(idSymbolLabel)
        scrollViewer.addSubview(tickerSymbolSymbolLabel)
        scrollViewer.addSubview(isinSymbolLabel)
        scrollViewer.addSubview(currencySymbolLabel)
        scrollViewer.addSubview(stockExchangeNameSymbolLabel)
        scrollViewer.addSubview(decorativeNameSymbolLabel)
        scrollViewer.addSubview(lastSymbolLabel)
        scrollViewer.addSubview(highSymbolLabel)
        scrollViewer.addSubview(bidSymbolLabel)
        scrollViewer.addSubview(lowSymbolSymbolLabel)
        scrollViewer.addSubview(volumeSymbolLabel)
        scrollViewer.addSubview(dateTimeSymbolLabel)
        scrollViewer.addSubview(changeSymbolLabel)
        scrollViewer.addSubview(changePercentSymbolLabel)
        
        NSLayoutConstraint.activate([

            scrollViewer.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0),
            scrollViewer.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            scrollViewer.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0),
            scrollViewer.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            
            idSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            idSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            idSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            idSymbolLabel.topAnchor.constraint(equalTo: scrollViewer.topAnchor, constant: 10),

            tickerSymbolSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            tickerSymbolSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            tickerSymbolSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            tickerSymbolSymbolLabel.topAnchor.constraint(equalTo: idSymbolLabel.bottomAnchor, constant: 5),

            isinSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            isinSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            isinSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            isinSymbolLabel.topAnchor.constraint(equalTo: tickerSymbolSymbolLabel.bottomAnchor, constant: 5),

            currencySymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            currencySymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            currencySymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            currencySymbolLabel.topAnchor.constraint(equalTo: isinSymbolLabel.bottomAnchor, constant: 5),

            stockExchangeNameSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            stockExchangeNameSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            stockExchangeNameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            stockExchangeNameSymbolLabel.topAnchor.constraint(equalTo: currencySymbolLabel.bottomAnchor, constant: 5),

            decorativeNameSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            decorativeNameSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            decorativeNameSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            decorativeNameSymbolLabel.topAnchor.constraint(equalTo: stockExchangeNameSymbolLabel.bottomAnchor, constant: 5),

            lastSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            lastSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            lastSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            lastSymbolLabel.topAnchor.constraint(equalTo: decorativeNameSymbolLabel.bottomAnchor, constant: 5),

            highSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            highSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            highSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            highSymbolLabel.topAnchor.constraint(equalTo: lastSymbolLabel.bottomAnchor, constant: 5),
            
            bidSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            bidSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            bidSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            bidSymbolLabel.topAnchor.constraint(equalTo: highSymbolLabel.bottomAnchor, constant: 5),

            lowSymbolSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            lowSymbolSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            lowSymbolSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            lowSymbolSymbolLabel.topAnchor.constraint(equalTo: bidSymbolLabel.bottomAnchor, constant: 5),

            volumeSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            volumeSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            volumeSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            volumeSymbolLabel.topAnchor.constraint(equalTo: lowSymbolSymbolLabel.bottomAnchor, constant: 5),

            dateTimeSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            dateTimeSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            dateTimeSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            dateTimeSymbolLabel.topAnchor.constraint(equalTo: volumeSymbolLabel.bottomAnchor, constant: 5),

            changeSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            changeSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            changeSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            changeSymbolLabel.topAnchor.constraint(equalTo: dateTimeSymbolLabel.bottomAnchor, constant: 5),

            changePercentSymbolLabel.leadingAnchor.constraint(equalTo: scrollViewer.leadingAnchor, constant: 5),
            changePercentSymbolLabel.widthAnchor.constraint(equalToConstant: widthLabel),
            changePercentSymbolLabel.heightAnchor.constraint(equalToConstant: 30),
            changePercentSymbolLabel.topAnchor.constraint(equalTo: changeSymbolLabel.bottomAnchor, constant: 5),
            changePercentSymbolLabel.bottomAnchor.constraint(equalTo: scrollViewer.bottomAnchor, constant: -5),

        ])
    }
}
