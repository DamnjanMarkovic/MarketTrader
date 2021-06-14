//
//  SymbolViewController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

extension SymbolViewController: SymbolDelegate {
    var selectionFormating: Bool {
        get {
            selectionFormatingOriginal
        }
        set {
            self.selectionFormatingOriginal = newValue
        }
    }
    
    
    func returnMarketSymbolsProtocolFunc(symbolList: [Symbol]) {
        DispatchQueue.main.async {
            self.symbolList = symbolList
        }
    }
    
    func UpdateSymbolList(symbolList: [Symbol]) {
        DispatchQueue.main.async {
            self.symbolList = symbolList
            self.tableView.reloadData()
        }
    }
    
}


class SymbolViewController: UIViewController, UIPopoverPresentationControllerDelegate, UINavigationControllerDelegate {
    

    var sortSymbolsBy: SortingSelection = SortingSelection.NONAlphabetically {
        didSet {
            symbolViewModel.reorderList(symbolList: symbolList, sortingSelection: sortSymbolsBy)
            UserDefaults.standard.set(sortSymbolsBy.rawValue, forKey: "sortSymbolsBy")
            tableView.reloadData()
        }
    }
    
    var shouldRefresh = false {
        didSet {
            UserDefaults.standard.set(shouldRefresh, forKey: "shouldRefresh")
            HandleListRefreshing(shouldRefresh: shouldRefresh)
            tableView.reloadData()
        }
    }
    
    var selectionFormatingOriginal: Bool = true {
        didSet {
            UserDefaults.standard.set(selectionFormatingOriginal, forKey: "selectionFormatingOriginal")
            tableView.reloadData()
        }
    }
    
    var symbolList = [Symbol]()
    var selectedSymbol = Symbol()
    weak var coordinator: SymbolCoordinator?
    var symbolViewModel: SymbolViewModel = SymbolViewModel()
    var refreshingInterval = Int.random(in: 4...30)

    
    let sortSymbolsVC = SortSymbolsVC()
    
    private let tableStackView: UIStackView = {
        let view = UIStackView()
        view.clipsToBounds = true
        return view
    }()
    
    
    var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        symbolViewModel.delegate = self
        getMarketSymbols()
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        selectionFormatingOriginal = UserDefaults.standard.bool(forKey: "selectionFormatingOriginal")
        sortSymbolsBy = SortingSelection(rawValue: UserDefaults.standard.integer(forKey: "sortSymbolsBy")) ?? SortingSelection.Default
        shouldRefresh = UserDefaults.standard.bool(forKey: "shouldRefresh")
        symbolViewModel.reorderList(symbolList: symbolList, sortingSelection: sortSymbolsBy)
    }

    func HandleListRefreshing(shouldRefresh: Bool){
  
        symbolViewModel.RefreshList(symbolList: symbolList, shouldRefresh: shouldRefresh)

    }
    
    func getMarketSymbols() {
        symbolViewModel.returnMarketSymbols() { [self] success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.configureTableView()
                }
            }
        }
    }
    
    @objc func SortSymbolsFunc() {
        
        sortSymbolsVC.symbolsDefault.addTarget(self, action: #selector(SortSymbols), for: .touchUpInside)
        sortSymbolsVC.symbolsAlphabetically.addTarget(self, action: #selector(SortSymbols), for: .touchUpInside)
        sortSymbolsVC.symbolsNonAlphabetically.addTarget(self, action: #selector(SortSymbols), for: .touchUpInside)
        
        self.present(sortSymbolsVC, animated: true, completion: nil)
    }
    @objc func SortSymbols(button: UIButton) {
        sortSymbolsVC.dismiss(animated: true, completion: nil)
        sortSymbolsBy = SortingSelection(rawValue: button.tag)!
    }
    
    @objc func ChangeViewFormatting() {
        
        symbolViewModel.presentFormatingSelectionMenu(symbolViewController: self)
    }
}

    //UITableView Delegate Methods
    extension SymbolViewController : UITableViewDelegate, UITableViewDataSource {

        func configureTableView() {
            
            tableView.delegate = self
            tableView.dataSource = self
            tableView.translatesAutoresizingMaskIntoConstraints = false
            tableView.separatorStyle = .none
            tableStackView.addSubview(tableView)
            tableView.rowHeight = view.frame.height / 20
            tableView.register(SymbolHeaderView.self, forHeaderFooterViewReuseIdentifier: Constants.MARKET_HEADER_IDENTIFIER)
            tableView.register(SymbolViewCell.self, forCellReuseIdentifier: Constants.MARKET_CELL_IDENTIFIER)
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
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.MARKET_CELL_IDENTIFIER) as! SymbolViewCell
            let symbol = symbolList[indexPath.row]
            cell.SetCellValues(symbol: symbol, selectionFormatOriginal: selectionFormatingOriginal)
            
            return cell
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
        
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.MARKET_HEADER_IDENTIFIER) as! SymbolHeaderView

            view.SetFormating(selectionFormatingOriginal: selectionFormatingOriginal)
            view.nameSymbolButton.addTarget(self, action: #selector(SortSymbolsFunc), for: .touchUpInside)
            view.lastHighLowQuoteButton.addTarget(self, action: #selector(ChangeViewFormatting), for: .touchUpInside)
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
            vc.symbol = symbolSelected
            vc.refreshingInterval = refreshingInterval
            vc.shouldRefresh = shouldRefresh
            vc.refreshingInterval = refreshingInterval
            vc.modalPresentationStyle = .fullScreen
            self.navigationController!.pushViewController(vc, animated: true)
            
            
        }

    }
