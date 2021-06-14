//
//  SymbolViewModel.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//


import UIKit

protocol SymbolDelegate {
    func returnMarketSymbolsProtocolFunc(symbolList: [Symbol])
    func UpdateSymbolList(symbolList: [Symbol])
    var selectionFormating: Bool { get set }
    
}


class SymbolViewModel: NSObject {

    var delegate: SymbolDelegate?
    var symbolList = [Symbol]()
    private var timer: Timer?
    var refreshingInterval = 1
    
    
    override init() {
        super.init()

    }
    func presentFormatingSelectionMenu(symbolViewController: UIViewController) {
        let ac = UIAlertController(title: "Please select presenting type:", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "name / change percent / last", style: .default, handler: formatSelectionMenu))
        ac.addAction(UIAlertAction(title: "name / bid / high", style: .default, handler: formatSelectionMenu))
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        symbolViewController.present(ac, animated: true)
    }
    
    @objc func formatSelectionMenu(_ sender: UIAlertAction) {
        switch sender.title {
        case "name / change percent / last":
            delegate?.selectionFormating = true;
        case "name / bid / high":
            delegate?.selectionFormating = false
        default:
            print("")
        }
        
    }
    
    func RefreshList(symbolList: [Symbol], shouldRefresh: Bool) {
        
        if shouldRefresh {
            self.symbolList = symbolList
            
            refreshingInterval = Int.random(in: 4...30)
            refreshingInterval = 6
            timer = Timer.scheduledTimer(timeInterval: TimeInterval(refreshingInterval), target: self, selector: #selector(RefreshValues), userInfo: nil, repeats: true)
        }
        
        else {
            if timer != nil {
                timer?.invalidate()
                timer = nil
            }
        }

    }
    
    
    @objc func RefreshValues() {
        
        for symbol in symbolList {
            
            symbol.quote.changePercent = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.changePercent)
            symbol.quote.last = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.last)
            symbol.quote.bid = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.bid)
            symbol.quote.high = RefreshHelpers.GetChangedValueDouble(value: symbol.quote.high)
        
        }
        delegate?.UpdateSymbolList(symbolList: symbolList)
    }
    
    
    
    func reorderList(symbolList: [Symbol], sortingSelection: SortingSelection) {
        
        switch sortingSelection {
        
            case SortingSelection.Default:
                let newList = Singletone.symbolsList
                if let oldListSaved = newList {
                    delegate?.UpdateSymbolList(symbolList: oldListSaved)
                }

            case SortingSelection.Alphabetically:
                    let newList = symbolList.sorted(by: { $0.name < $1.name })
                    delegate?.UpdateSymbolList(symbolList: newList)
            
            case SortingSelection.NONAlphabetically:
                    let newList = symbolList.sorted(by: { $0.name > $1.name })
                    delegate?.UpdateSymbolList(symbolList: newList)
        }
    }
    
    
    
    func returnMarketSymbols(completition: @escaping ((_ success: Bool) -> ())) {
        
        let url = URL (string: Constants.SYMBOLMARKETLINK)
        guard let unwrappedUrl = url else { return }
        
        let apiService = APIService()

        apiService.getMarketSymbols(of: Data.self, from: unwrappedUrl) { (result) in
            switch result {
                
                case .failure(let error):
                    if error is DataError {
                        print(error)
                    } else {
                        print(error.localizedDescription)
                    }
                    print(error.localizedDescription)
                    
                case .success(let unwrappedData):
                    let xmlParserHelper = XMLParserSymbolMarket()
                    DispatchQueue.main.async { [self] in
                    xmlParserHelper.unwrapSymbolList(unwrappedData) { (symbolListArrived) in
                        
                        if let symbolListArrivedUnwrapped = symbolListArrived {
                            Singletone.symbolsList = symbolListArrivedUnwrapped
                            
                            self.symbolList = symbolListArrivedUnwrapped
                            self.delegate?.returnMarketSymbolsProtocolFunc(symbolList: symbolListArrivedUnwrapped)
                            completition(true)
                        }
                    }
                }
            }
        }
    }
}
