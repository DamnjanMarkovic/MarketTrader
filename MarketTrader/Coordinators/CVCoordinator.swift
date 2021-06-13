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
        vc.tabBarItem = UITabBarItem(title: "CV", image: Constants.TAB_CV, selectedImage: Constants.TAB_CV_CHECKED)
        navigationController.pushViewController(vc, animated: true)

    }

}
