//
//  MarketViewController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

extension MarketsViewController: MarketsDelegate {
    
    func returnMarketSymbolsProtocolFunc(symbolList: [Symbol]) {
        DispatchQueue.main.async {
            self.symbolList = symbolList
        }
    }
    
    func reOrderSymbolList(symbolList: [Symbol], button: UIButton) {
        DispatchQueue.main.async {
            self.symbolList = symbolList
            self.tableView.reloadData()
            self.configureTableView()
        }
    }
}


class MarketsViewController: UIViewController, UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate {
    
    var symbolList = [Symbol]()
    var selectedSymbol = Symbol()
    weak var coordinator: MarketsCoordinator?
    var marketViewModel: MarketsViewModel = MarketsViewModel()
    var buttonSymbolName = UIButton()
    var selectionFormatingOriginal = true
    let libraryVC = NameOrderPopover()
    
    private let tableStackView: UIStackView = {
        let view = UIStackView()
        view.clipsToBounds = true
        return view
    }()
    
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        marketViewModel.delegate = self
        getMarketSymbols()
        

    }

    
    func getMarketSymbols() {
        marketViewModel.returnMarketSymbols() { [self] success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.configureTableView()
                }
            }
        }
    }
    
    @objc func lineUpList() {
        
        libraryVC.symbolsDefault.addTarget(self, action: #selector(GetVIewModelToSortTheList), for: .touchUpInside)
        libraryVC.symbolsAlphabetically.addTarget(self, action: #selector(GetVIewModelToSortTheList), for: .touchUpInside)
        libraryVC.symbolsNonAlphabetically.addTarget(self, action: #selector(GetVIewModelToSortTheList), for: .touchUpInside)
        
        self.present(libraryVC, animated: true, completion: nil)
    }
    @objc func GetVIewModelToSortTheList(button: UIButton) {
        libraryVC.dismiss(animated: true, completion: nil)
        marketViewModel.reorderList(symbolList: symbolList, button: button)
    }
    
    func presentFormatingSelectionMenu() {
        let ac = UIAlertController(title: "Please select presenting type:", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "name / change percent / last", style: .default, handler: formatSelectionMenu))
        ac.addAction(UIAlertAction(title: "name / bid / high", style: .cancel, handler: formatSelectionMenu))
        self.present(ac, animated: true)
    }
    
    @objc func formatSelectionMenu(_ sender: UIAlertAction) {
        switch sender.title {
        case "name / change percent / last":
            selectionFormatingOriginal = true;
            tableView.reloadData()
        case "name / bid / high":
            selectionFormatingOriginal = false
            tableView.reloadData()
        default:
            print("")
        }
        
    }
    

}

    //UITableView Delegate Methods
    extension MarketsViewController : UITableViewDelegate, UITableViewDataSource {

        func configureTableView() {
            
            tableView.delegate = self
            tableView.dataSource = self
            
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorStyle = .none
            
            tableStackView.addSubview(tableView)
            tableView.rowHeight = view.frame.height / 20
            
            tableView.register(MarketsHeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.MARKET_HEADER_IDENTIFIER)
            tableView.register(MarketsViewCell.self, forCellReuseIdentifier: Constants.MARKET_CELL_IDENTIFIER)
            tableView.delegate = self
            tableView.dataSource = self
            tableView.set(to: tableStackView)
            tableStackView.frame = CGRect(x: 0, y: 0, width: view.width, height: view.height)
            view.addSubview(tableStackView)
        }
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1

        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return symbolList.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MARKET_CELL_IDENTIFIER) as! MarketsViewCell
            
            let symbol = symbolList[indexPath.row]
            
            if selectionFormatingOriginal {
                
                if symbol.quote.changePercent > 0 {
                    cell.changePercentBidAskQuoteLabel.textColor = .green
                }
                else if (symbol.quote.changePercent == 0) {
                }
                else {
                    cell.changePercentBidAskQuoteLabel.textColor = .red
                }
                
                cell.nameSymbolLabel.text = symbol.name
                cell.changePercentBidAskQuoteLabel.text = "\(symbol.quote.changePercent)"
                cell.lastHighLowQuoteLabel.text = "\(symbol.quote.last)"
            }
            
            else {
                cell.nameSymbolLabel.text = symbol.name
                cell.changePercentBidAskQuoteLabel.text = "\(symbol.quote.bid)"
                cell.lastHighLowQuoteLabel.text = "\(symbol.quote.high)"
            }
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.MARKET_HEADER_IDENTIFIER) as! MarketsHeaderView
            buttonSymbolName = view.nameSymbolButton
            view.SetFormating(selectionFormatingOriginal: selectionFormatingOriginal)
            view.nameSymbolButton.addTarget(self, action: #selector(lineUpList), for: .touchUpInside)
            
            return view
        }

        
        func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                symbolList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } 
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            
            let symbolSelected = symbolList[indexPath.row]
            
            let vc = SymbolDetailsViewController()
            vc.symbolSelected = symbolSelected
            vc.modalPresentationStyle = .fullScreen
            self.navigationController!.pushViewController(vc, animated: true)
            
            
        }

    }
