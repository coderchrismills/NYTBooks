//
//  Lists.swift
//  
//
//  Created by Richard Mills on 10/3/20.
//

import Foundation
import ArgumentParser
import Chalk
import SwiftyJSON
import SwiftyTextTable

extension NYTBooks {
    struct List: ParsableCommand {
        enum PurchaseType: EnumerableFlag {
            case amazon
            case bookshop
            case indiebound
            
            var name: String {
                switch self {
                case .amazon: return "Amazon"
                case .bookshop: return "BookShop"
                case .indiebound: return "IndieBound"
                }
            }
        }
        
        static let configuration = CommandConfiguration(
            commandName:"list",
            abstract: "Get Best Sellers list")

        init() { }
        
        @Flag
        private var categories: Bool = false
        
        @Option(name: .shortAndLong, help: "List index to search for (default: Hardcover Nonfiction)")
        private var categoryIndex: Int = 0
        
        @Flag(help: "Change the purchase link")
        private var purchase: PurchaseType = .amazon
        
        func validate() throws {
            let _ = try NYTBooks.getApiKey()
        }
        
        func run() throws {
            if categories {
                displayList()
                return
            }
            
            var searchList = NYTList.Names.hardCoverNonFiction
            
            if categoryIndex > 0 {
                let lists = NYTList.Names.allCases
                searchList = lists[categoryIndex-1]
            }
            
            let sema = DispatchSemaphore( value: 0)
            
            let apiKey = try NYTBooks.getApiKey()
            
            let uriString = "https://api.nytimes.com/svc/books/v3/lists.json"
            let url = URL(string: "\(uriString)?list=\(searchList.encoded)&api-key=\(apiKey)")!
            
            let titleHeader = TextTableColumn(header: "Title")
            let authorHeader = TextTableColumn(header: "Author")
            let isbn13Header = TextTableColumn(header: "ISBN 13")
            let amazonHeader = TextTableColumn(header: purchase.name)
        
            var table = TextTable(columns: [titleHeader, authorHeader,
                                            isbn13Header, amazonHeader])
            
            table.header = searchList.rawValue
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = JSON(data)
                    let results = json["results"]
                    let resultArray = results.map { $0.1 }
                    
                    for item in resultArray {
                        let bookDetail = item["book_details"][0]
                        let isbn13 = bookDetail["primary_isbn13"].stringValue
                        var storeLink = ""
                        switch purchase {
                        case .amazon:
                            storeLink = item["amazon_product_url"].stringValue
                        case .bookshop:
                            storeLink = "https://bookshop.org/a/3546/\(isbn13)"
                        case .indiebound:
                            storeLink = "https://www.indiebound.org/book/\(isbn13)?aff=NYT"
                        }
                        
                        table.addRow(values: ["\(bookDetail["title"].stringValue.truncated().localizedCapitalized)",
                                              bookDetail["author"].stringValue.truncated(),
                                      bookDetail["primary_isbn13"].stringValue.truncated(),
                                      storeLink])
                    }
                }
                sema.signal()
            }
            task.resume()

            sema.wait() // sets the process to wait
            
            let tableString = table.render()
            print(tableString)
        }
        
        func displayList() {
            var index = 0
            NYTList.Names.allCases.forEach { item in
                index = index + 1
                print("  \(index, color: .yellow)\t\(item.rawValue)")
            }
        }
    }

}
