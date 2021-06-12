//
//  NameOrderPopover.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class NameOrderPopover: UIViewController, UIPopoverPresentationControllerDelegate {
    
    
    let symbolsAlphabetically: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Alphabetically", for: .normal)
        button.tag = SortingSelection.Alphabetically.hashValue
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        return button
    }()
    
    let symbolsNonAlphabetically: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NON Alphabetically", for: .normal)
        button.tag = SortingSelection.NONAlphabetically.hashValue
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        return button
    }()
    
    let symbolsDefault: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Default sorting", for: .normal)
        button.tag = SortingSelection.Default.hashValue
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.black
        button.layer.cornerRadius = 5
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.modalPresentationStyle = .popover

        if let popover = self.popoverPresentationController
        {
            popover.delegate = self
        }

        self.preferredContentSize = CGSize(width: 50, height: 100)
        self.view.backgroundColor = .clear
        self.view.layer.borderColor  = UIColor.white.cgColor
        self.view.layer.borderWidth  = 5.0
        self.view.layer.cornerRadius = 16.0
        configureContents()
    
    }
    
    func configureContents() {
        
        symbolsAlphabetically.translatesAutoresizingMaskIntoConstraints = false
        symbolsNonAlphabetically.translatesAutoresizingMaskIntoConstraints = false
        symbolsDefault.translatesAutoresizingMaskIntoConstraints = false

        self.view.addSubview(symbolsAlphabetically)
        self.view.addSubview(symbolsNonAlphabetically)
        self.view.addSubview(symbolsDefault)


        NSLayoutConstraint.activate([

            symbolsAlphabetically.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            symbolsAlphabetically.heightAnchor.constraint(equalToConstant: 50),
            symbolsAlphabetically.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 50),
            symbolsAlphabetically.centerXAnchor.constraint(equalTo:  self.view.centerXAnchor),

            
            
            symbolsNonAlphabetically.heightAnchor.constraint(equalToConstant: 50),
            symbolsNonAlphabetically.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            symbolsNonAlphabetically.topAnchor.constraint(equalTo: symbolsAlphabetically.bottomAnchor, constant: 30),
            symbolsNonAlphabetically.centerXAnchor.constraint(equalTo:  self.view.centerXAnchor),
       
            
            symbolsDefault.heightAnchor.constraint(equalToConstant: 50),
            symbolsDefault.centerXAnchor.constraint(equalTo:  self.view.centerXAnchor),
            symbolsDefault.widthAnchor.constraint(equalToConstant: self.view.frame.width/2),
            symbolsDefault.topAnchor.constraint(equalTo: symbolsNonAlphabetically.bottomAnchor, constant: 30),
        ])
    
    }
}

