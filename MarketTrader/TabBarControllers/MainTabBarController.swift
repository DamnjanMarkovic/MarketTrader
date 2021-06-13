//
//  MainTabBarController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

class MainTabBarController: UITabBarController {
    
    let mainCoordinator = MainCoordinator(navigationController: UINavigationController())
    let marketCoordinator = SymbolCoordinator(navigationController: UINavigationController())
    let newsCoordinator = NewsCoordinator(navigationController: UINavigationController())
    let cvCoordinator = CVCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        mainCoordinator.start()
        marketCoordinator.start()
        newsCoordinator.start()
        cvCoordinator.start()
        viewControllers = [marketCoordinator.navigationController,
                           newsCoordinator.navigationController, cvCoordinator.navigationController]
        
    }
    
}
