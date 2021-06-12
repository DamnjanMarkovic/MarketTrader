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
}


class MarketsViewController: UIViewController {
    
    var symbolList = [Symbol]()
    weak var coordinator: MarketsCoordinator?
    var marketViewModel: MarketsViewModel = MarketsViewModel()
    
    
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
        marketViewModel.returnMarketSymbols() { success in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.configureTableView()
                }
            }
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
            cell.nameSymbolLabel.text = symbol.name
            cell.changePercentBidAskQuoteLabel.text = "\(symbol.quote.changePercent)"
            cell.lastHighLowQuoteLabel.text = "\(symbol.quote.last)"
            return cell
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

            let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: Constants.MARKET_HEADER_IDENTIFIER) as! MarketsHeaderView
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
            
//            let koloKliknuto = narednaKola[indexPath.row]
//
//            ///provera  da li je vreme za uplatu isteklo, ona ce omoguciti izbor polja. Ako je vreme isteklo, ne moze se ici na biranje
//
//            if koloKliknuto.drawTime > Double(TimeFunctions.vratiVremeSada()) {
//                Singletone.Instanca.koloKliknuto = koloKliknuto
//
//                let talonVC = Talon()
//                let navController = UINavigationController(rootViewController: talonVC)
//                navController.modalPresentationStyle = .overFullScreen
//                self.present(navController, animated: false)
//            }
//            else {
//                let ac = UIAlertController(title: "Jbg, vreme je isteklo.", message: nil, preferredStyle: .alert)
//                ac.addAction(UIAlertAction(title: "OK, sta da se radi", style: .default, handler: nil))
//                self.present(ac, animated: true)
//            }
            
        }

    }
