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

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        
        let vc = MarketsViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.tabBarItem = UITabBarItem(title: "Market", image: .actions, selectedImage: .checkmark)
        self.navigationController.pushViewController(vc, animated: true)

    }
    
}
