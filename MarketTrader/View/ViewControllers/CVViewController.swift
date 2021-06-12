//
//  CVViewController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit
import WebKit
import PDFKit

class CVViewController: UIViewController, WKNavigationDelegate {
    
    weak var coordinator: NewsCoordinator?

    
    var pdfView = PDFView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemPink
        postaviUI()
        postaviStranicu()

    }
    
    func postaviUI() {
        pdfView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(pdfView)

        pdfView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        pdfView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        pdfView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        pdfView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    
    func postaviStranicu() {
        
        if let path = Bundle.main.path(forResource: "CV Damnjan Markovic", ofType: "pdf") {
                    if let pdfDocument = PDFDocument(url: URL(fileURLWithPath: path)) {
                        
                        pdfView.displayMode = .singlePageContinuous
                        pdfView.autoScales = true
                        pdfView.displayDirection = .vertical
                        pdfView.document = pdfDocument
                    }
                }
        
    }
}
