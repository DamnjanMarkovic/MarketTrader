//
//  Coordinator.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

protocol Coordinator: AnyObject {
    
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }

    func start()
}
