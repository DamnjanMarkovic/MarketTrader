//
//  NewsViewCell.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class NewsViewCell: UICollectionViewCell {
    
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
        configureContents()
        self.backgroundColor = .blue
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        // Configure the view for the selected state
    
    
    func setup(with news: NewsArticle) {
        
        let imageLink = "\(Constants.IMAGESLINK)\(news.imageID)\(Constants.SMALLIMAGESIZE)"
        imageView.loadImage(with: imageLink)
        imageView.contentMode = .scaleAspectFit
        self.headlineLabel.text = news.headline
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

        contentView.addSubview(imageView)
        contentView.addSubview(headlineLabel)


        NSLayoutConstraint.activate([

            imageView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 200),

            headlineLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            headlineLabel.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            headlineLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20),
         
        ])
    
    }
}
