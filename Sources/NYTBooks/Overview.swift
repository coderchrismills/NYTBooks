//
//  Overview.swift
//  
//
//  Created by Richard Mills on 10/3/20.
//

import Foundation
import ArgumentParser
import Chalk
import SwiftyJSON

extension NYTBooks {
    struct Overview: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "overview", abstract: "Get an overview of the best seller list")
        
        @Option(name: .shortAndLong, help:"List index to show overview for [nytb --list]")
        private var listIndex: Int = 0
        
        @Option(name: .shortAndLong, help: "Date to get the best seller list for. YYYY-MM-DD format only")
        private var date: String = ""
        
        func validate() throws {
            let _ = try NYTBooks.getApiKey()
            
            if date.count > 0 {
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-mm-dd"
                if formatter.date(from: date) == nil {
                    throw ValidationError("\("Date not in yyyy-mm-dd format", color: .magenta)")
                }
            }
        }
        
        func run() throws {
            let apiKey = try NYTBooks.getApiKey()
            
            let sema = DispatchSemaphore( value: 0)
            
            let uriString = "https://api.nytimes.com/svc/books/v3/lists/overview.json"
            
            var dateQuery = ""
            if date.count > 0 {
                dateQuery = "published_date=\(date)&"
            }
            
            let url = URL(string: "\(uriString)?\(dateQuery)api-key=\(apiKey)")!
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = JSON(data)
                    
                    if listIndex > 0 {
                        let listName = NYTList.Names.allCases[listIndex-1]
                        let results = json["results"]["lists"].filter { item in
                            let listItem = item.1
                            let displayName = listItem["display_name"].stringValue
                            if let display = NYTList.Names(rawValue: displayName) {
                                return display == listName
                            }
                            return false
                        }
                        if results.count == 1 {
                            displayList(list: [results[0].1])
                        }
                    } else {
                        let results = json["results"]["lists"]
                        let resultArray = results.map { $0.1 }
                        displayList(list: resultArray)
                    }
                }
                sema.signal()
            }
            task.resume()

            sema.wait() // sets the process to wait
        }
        
        func displayList(list: [JSON]) {
            for item in list {
                let listName = item["display_name"].stringValue
                let books = item["books"].map { $0.1 }
                if books.count > 0 {
                    print("\(listName, color: .green, style: [.underlined, .bold])")
                    for book in books {
                        displayBook(book: book)
                        print("\n")
                    }
                }
            }
        }
        
        func displayBook(book: JSON) {
            let author = book["author"].stringValue
            let description = book["description"].stringValue
            let rank = book["rank"].stringValue
            let title = book["title"].stringValue.localizedCapitalized
            let buyLinks = book["buy_links"].map { $0.1 }
            
            print("\(rank, color: .yellow) \(title, color: .blue) | by: \(author, color: .green)")
            print("  Description: \(description)".wrap())
            print("  Purchase:")
            for link in buyLinks {
                let name = link["name"].stringValue
                if name.contains("Amazon") || name.contains("Bookshop") || name.contains("Indiebound") {
                    print("    \(link["name"].stringValue):\(link["url"], color: .cyan)")
                }
            }
        }
    }
}

