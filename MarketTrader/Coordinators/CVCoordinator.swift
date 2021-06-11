//
//  CVCoordinator.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class CVCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    weak var parentCoordinator: MainCoordinator?
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        let vc = CVViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.tabBarItem = UITabBarItem(title: "CV", image: .actions, selectedImage: .checkmark)
        navigationController.pushViewController(vc, animated: true)

    }

}
