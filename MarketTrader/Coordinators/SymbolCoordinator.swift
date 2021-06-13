//
//  SymbolCoordinator.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

class SymbolCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let vc = SymbolViewController()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        
        vc.modalPresentationStyle = .fullScreen
        vc.tabBarItem = UITabBarItem(title: "Market", image: Constants.TAB_SYMBOL, selectedImage: Constants.TAB_SYMBOL_CHECKED)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.IMAGEMARKETREFRESHBUTTON!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(refreshList))
        
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Constants.IMAGEMARKETSETTINGSBUTTON!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeViewFormatting))
        self.navigationController.pushViewController(vc, animated: true)

    }
    
    
    @objc func refreshList() {
        
        vc.symbolViewModel.returnMarketSymbols() { success in
            if success {
                DispatchQueue.main.async {
                    self.vc.tableView.reloadData()
                }
            }
        }
    }
    @objc func changeViewFormatting() {
        
        self.vc.presentFormatingSelectionMenu()
    }
    
}
