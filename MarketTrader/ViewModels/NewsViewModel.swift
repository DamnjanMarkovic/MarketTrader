//
//  NewsViewModel.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 11.6.21..
//

import UIKit

protocol NewsDelegate {
    func returnNewsProtocolFunc(news: [NewsArticle])
}

class NewsViewModel : NSObject {
    
    var delegate: NewsDelegate?
    var newsArticles = [NewsArticle]()
    
    override init() {
        super.init()
    }
    
    func returnNews(completition: @escaping ((_ success: Bool) -> ())) {
        
        let url = URL (string: Constants.NEWSLINK)
        guard let unwrappedUrl = url else { return }
        
        let apiService = APIService()

        apiService.getNews(of: Data.self, from: unwrappedUrl) { (result) in
            switch result {
                
                case .failure(let error):
                    if error is DataError {
                        print(error)
                    } else {
                        print(error.localizedDescription)
                    }
                    print(error.localizedDescription)
                    
                case .success(let unwrappedData):
                    let xmlParserHelper = XMLParserNews()
                    DispatchQueue.main.async { [self] in
                    xmlParserHelper.unwrapNewsList(unwrappedData) { (newsArticlesArrived) in
                        
                        if let newsArticlesArrivedUnwrapped = newsArticlesArrived {
                            
                            self.newsArticles = newsArticlesArrivedUnwrapped
                            self.delegate?.returnNewsProtocolFunc(news: newsArticlesArrivedUnwrapped)
                            completition(true)
                        }
                    }
                }
            }
        }
    }
    
}
