//
//  MarketViewModel.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//


import UIKit

protocol MarketsDelegate {
    func returnMarketSymbolsProtocolFunc(symbolList: [Symbol])
    func reOrderSymbolList(symbolList: [Symbol], button: UIButton)
}


class MarketsViewModel: NSObject, XMLParserDelegate {

    var delegate: MarketsDelegate?
    var symbolList = [Symbol]()

    
    
    override init() {
        super.init()
    }

    
    func reorderList(symbolList: [Symbol], button: UIButton) {
        switch button.tag {
        
        case SortingSelection.Default.hashValue:
            let newList = Singletone.symbolsList
            if let oldListSaved = newList {
                delegate?.reOrderSymbolList(symbolList: oldListSaved, button: button)
            }

        case SortingSelection.Alphabetically.hashValue:
                let newList = symbolList.sorted(by: { $0.name > $1.name })
                delegate?.reOrderSymbolList(symbolList: newList, button: button)
        
        case SortingSelection.NONAlphabetically.hashValue:
                let newList = symbolList.sorted(by: { $0.name < $1.name })
                delegate?.reOrderSymbolList(symbolList: newList, button: button)

        default:
            print("")
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
                    let xmlParserHelper = XMLParserHelper()
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
