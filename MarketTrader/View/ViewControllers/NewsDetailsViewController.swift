//
//  NewsDetails.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class NewsDetailsViewController: UIViewController {

    
    var newsSelected = NewsArticle()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.title = newsSelected.headline
        configureContents()
        SetContentElementSize()
        
        let imageLink = "\(Constants.IMAGESLINK)\(newsSelected.imageID)\(Constants.MIDDLEIMAGESIZE)"
        textOverImage(imageLocation: imageLink)

    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
            super.willTransition(to: newCollection, with: coordinator)
            
        coordinator.animate(alongsideTransition: { [self] (context) in
                guard let windowInterfaceOrientation = self.windowInterfaceOrientation else { return }
                
                if windowInterfaceOrientation.isLandscape {
                    SetImageOverFullScreen()
                    textOverImage(imageLocation: "\(Constants.IMAGESLINK)\(self.newsSelected.imageID)\(Constants.BIGIMAGESIZE)")
                    
                } else {
                    SetContentElementSize()
                    textOverImage(imageLocation: "\(Constants.IMAGESLINK)\(self.newsSelected.imageID)\(Constants.MIDDLEIMAGESIZE)")
                }
            })
    }
        
    private var windowInterfaceOrientation: UIInterfaceOrientation? {
        return UIApplication.shared.windows.first?.windowScene?.interfaceOrientation
    }
    
    
    let imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 20
        imageView.layer.borderColor = UIColor.darkGray.cgColor
        imageView.layer.borderWidth = 1
        return imageView
    }()
    
    
    let headlineLabel: UILabel = {
        let label = UILabel()
        label.layer.cornerRadius = 2
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        label.textColor = Constants.FONTCOLORHEADER
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.backgroundColor = .clear
        label.font = Constants.FONTSTYLEHEADER
        label.text = "Name ↓ ↑"
        label.layer.borderColor = UIColor.darkGray.cgColor
        return label
    }()
    
    
    func textOverImage(imageLocation: String) {
        headlineLabel.text = newsSelected.headline
        imageView.loadImage(with: imageLocation)
        imageView.contentMode = .scaleAspectFit
        imageView.drawOnCurrentImage(view: headlineLabel, mode: .changeOriginalImage) { (parentSize, viewToAdd) in
            viewToAdd.font = UIFont.systemFont(ofSize: 18)
            viewToAdd.textColor = .red
            viewToAdd.textAlignment = .center
            viewToAdd.backgroundColor = .white
            viewToAdd.frame = CGRect(x: 40, y: 40, width: 200, height: 20)
        }
    }
    

    
    func configureContents() {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        headlineLabel.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(imageView)
        view.addSubview(headlineLabel)
    }
    
    func SetContentElementSize() {
        
        headlineLabel.text = newsSelected.headline
        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            imageView.heightAnchor.constraint(equalToConstant: view.frame.height/2),

            headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor),
            headlineLabel.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            headlineLabel.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: 10),
         
        ])
    }
    
    func SetImageOverFullScreen() {
        
        headlineLabel.text = ""
        
        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor)


         
        ])
    }
    


}
