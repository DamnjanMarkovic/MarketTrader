//
//  NewsFirstVC.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 13.6.21..
//

import UIKit

class NewsFirstVC: UICollectionViewCell {

    
    var news: NewsArticle?
    
    
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
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    func setup(with news: NewsArticle) {
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let imageLink = "\(Constants.IMAGESLINK)\(news.imageID)\(Constants.SMALLIMAGESIZE)"
        imageView.loadImage(with: imageLink)
        imageView.contentMode = .scaleToFill
        
        contentView.addSubview(imageView)

        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor),
         
        ])
        
            headlineLabel.text = news.headline
            imageView.drawOnCurrentImage(view: headlineLabel, mode: .changeOriginalImage) { (parentSize, viewToAdd) in
    
                viewToAdd.font = UIFont.systemFont(ofSize: 18)
                viewToAdd.textColor = .red
                viewToAdd.textAlignment = .center
                viewToAdd.backgroundColor = .white
                viewToAdd.frame = CGRect(x: 40, y: 40, width: 200, height: 20)
    
            }
    }
        
}
    
   
