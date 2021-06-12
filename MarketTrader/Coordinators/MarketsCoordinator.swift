//
//  MarketsCoordinator.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

class MarketsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let vc = MarketsViewController()

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        
//        let vc = MarketsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.tabBarItem = UITabBarItem(title: "Market", image: .actions, selectedImage: .checkmark)
        vc.navigationItem.leftBarButtonItem = UIBarButtonItem(image: Constants.IMAGEMARKETREFRESHBUTTON!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(refreshList))
        
        vc.navigationItem.rightBarButtonItem = UIBarButtonItem(image: Constants.IMAGEMARKETSETTINGSBUTTON!.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(changeViewFormatting))
        self.navigationController.pushViewController(vc, animated: true)

    }
    
    
    @objc func refreshList() {
        
        vc.getMarketSymbols()
            //change view

    }
    @objc func changeViewFormatting() {
        
            //refresh Data On User Request

    }
    
}
