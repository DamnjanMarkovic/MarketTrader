//
//  MainCoordinator.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

class MainCoordinator: NSObject, Coordinator, UINavigationControllerDelegate {
    
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        
        navigationController.delegate = self
        let vc = MainViewController()
        vc.coordinator = self;
        vc.modalPresentationStyle = .fullScreen
//        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .mostRecent, tag: 3)
        self.navigationController.pushViewController(vc, animated: true)

    }
    
    
    
//    func showMarketVC() {
//        
//        let child = MarketsCoordinator(navigationController: navigationController)
//        child.parentCoordinator = self
//        childCoordinators.append(child)
//        child.start()
//        
//        
//    }
//
//    func showNewsVC() {
//        let child = NewsCoordinator(navigationController: navigationController)
//        child.parentCoordinator = self
//        childCoordinators.append(child)
//        child.start()
//
//    }
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else {
            return
        }

        if navigationController.viewControllers.contains(fromViewController) {
            return
        }

        if let marketViewController = fromViewController as? MarketsViewController {
            childDidFinish(marketViewController.coordinator)
        }
        if let newsViewController = fromViewController as? NewsViewController {
            childDidFinish(newsViewController.coordinator)
        }
        if let cvViewController = fromViewController as? CVViewController {
            childDidFinish(cvViewController.coordinator)
        }
    }
    
    func childDidFinish(_ child: Coordinator?) {
        for (index, coordinator) in childCoordinators.enumerated() {
            if coordinator === child {
                childCoordinators.remove(at: index)
                break
            }
        }
    }
}


