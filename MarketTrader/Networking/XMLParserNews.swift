//
//  XMLParserNews.swift
//  MarketTrader
//
//  Created by Damnjan Markovic on 12.6.21..
//

import UIKit

class XMLParserNews: NSObject, XMLParserDelegate {
    
    var newsArticles = [NewsArticle]()


        var xmlDict = [String: Any]()
        var xmlDictArr = [[String: Any]]()
        var currentElement = ""
        var pictureCount = 1
    
    override init() {

    }

    func unwrapNewsList(_ unwrappedData: Data, completition: @escaping ((_ symbolList: [NewsArticle]?)->())) {
    
        let parser = XMLParser(data: unwrappedData)
        parser.delegate = self
        parser.parse()
        completition(newsArticles)
        
    }
    
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            if elementName == "NewsArticle" {
                xmlDict = [:]
            } else {
                currentElement = elementName
            }
        }

        func parser(_ parser: XMLParser, foundCharacters string: String) {
            
            if !string.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                if xmlDict[currentElement] == nil {
                       xmlDict.updateValue(string, forKey: currentElement)
                }
            }
        }

        func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {

            if elementName == "NewsArticle" {
                xmlDictArr.append(xmlDict)
            }
        }

        func parserDidEndDocument(_ parser: XMLParser) {
            parsingCompleted()
        }
        
        func parsingCompleted() {
            self.newsArticles = self.xmlDictArr.map { NewsArticle(details: $0) }
        }
        
    
}
