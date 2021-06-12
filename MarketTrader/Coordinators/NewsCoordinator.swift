//
//  NewsCoordinator.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

class NewsCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    let vc = NewsViewController()
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        vc.modalPresentationStyle = .fullScreen
        vc.tabBarItem = UITabBarItem(title: "News", image: .actions, selectedImage: .checkmark)
        navigationController.pushViewController(vc, animated: true)

    }
    


}
