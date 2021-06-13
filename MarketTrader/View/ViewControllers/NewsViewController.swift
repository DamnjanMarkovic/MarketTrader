//
//  NewsViewController.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

extension NewsViewController: NewsDelegate {
    
    func returnNewsProtocolFunc(news: [NewsArticle]) {
        DispatchQueue.main.async {
            self.newsArticles = news
        }
    }
}
class NewsViewController: UIViewController {
    
    var newsArticles = [NewsArticle]()
    
    var image: UIImage?
    
    var collectionView: UICollectionView = {
        let viewLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: viewLayout)
        collectionView.backgroundColor = .darkGray
        return collectionView
    }()
    
    weak var coordinator: NewsCoordinator?
    var newsViewModel: NewsViewModel = NewsViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .yellow
        newsViewModel.delegate = self
        setCollectionViewElements()
        getNews()

    }
    
    func setCollectionViewElements() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(NewsViewCell.self, forCellWithReuseIdentifier: Constants.NEWS_CELL_IDENTIFIER)
        collectionView.register(NewsFirstVC.self, forCellWithReuseIdentifier: Constants.NEWS_FIRST_CELL_IDENTIFIER)
        collectionView.backgroundColor = UIColor.darkGray
        collectionView.dataSource = self
        collectionView.delegate = self
        self.view.addSubview(collectionView)

    }
    
    func getNews() {
        newsViewModel.returnNews() { [self] success in
            if success {
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }
    }

}

extension NewsViewController: UICollectionViewDataSource {

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let news = newsArticles[indexPath.row]
        
        if indexPath.row == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.NEWS_FIRST_CELL_IDENTIFIER, for: indexPath as IndexPath) as! NewsFirstVC
            cell.setup(with: news)

            return cell
        }
        else {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.NEWS_CELL_IDENTIFIER, for: indexPath as IndexPath) as! NewsViewCell
            cell.setup(with: news)

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsArticles.count

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let news = newsArticles[indexPath.row]
        
        let vc = NewsDetailsViewController()
        vc.newsSelected = news
        vc.modalPresentationStyle = .fullScreen
        self.navigationController!.pushViewController(vc, animated: true)
        

    }

}

extension NewsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellWidthHeight = itemWidth(for: view.frame.width, spacing: LayoutConstant.spacing)
        
        return CGSize(width: cellWidthHeight, height: cellWidthHeight)
    }
    
    func itemWidth(for width: CGFloat, spacing: CGFloat) -> CGFloat {
        let itemsInRow: CGFloat = 1
        
        let totalSpacing: CGFloat = 2 * spacing + (itemsInRow - 1) * spacing
        let finalWidth = (width - totalSpacing) / itemsInRow
        
        return floor(finalWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: LayoutConstant.spacing, left: LayoutConstant.spacing, bottom: LayoutConstant.spacing, right: LayoutConstant.spacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return LayoutConstant.spacing
    }
}


