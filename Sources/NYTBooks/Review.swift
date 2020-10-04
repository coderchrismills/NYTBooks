//
//  Review.swift
//  
//
//  Created by Richard Mills on 10/3/20.
//

import Foundation
import ArgumentParser
import Chalk
import SwiftyJSON

extension NYTBooks {
    struct Review: ParsableCommand {
        static var configuration = CommandConfiguration(
            commandName: "review", abstract: "Get reviews for a given book")
        
        @Argument(help: "ISBN of book to get review for")
        private var isbn: Int
        
        func validate() throws {
            let _ = try NYTBooks.getApiKey()
            
            let digits = floor( log10( Double(isbn) ) ) + 1;
            if digits != 10 && digits != 13 {
                throw ValidationError("ISBN must be an isbn 10 or isbn 13 number")
            }
        }
        
        func run() throws {
            let apiKey = try NYTBooks.getApiKey()
            
            let sema = DispatchSemaphore( value: 0)

            let uriString = "https://api.nytimes.com/svc/books/v3/reviews.json"
            let url = URL(string: "\(uriString)?isbn=\(isbn)&api-key=\(apiKey)")!
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let data = data {
                    let json = JSON(data)
                    let results = json["results"]
                    let resultArray = results.map { $0.1 }
                    if resultArray.count > 0 {
                        let title = resultArray[0]["book_title"].stringValue
                        let author = resultArray[0]["book_author"].stringValue
                        print("\(title, color: .blue) by \(author, color: .green)")
                    }
                    
                    for item in resultArray {
                        let link = item["url"].stringValue
                        let byline = item["byline"].stringValue.localizedCapitalized
                        let summary = item["summary"].stringValue
                        print("\(summary.wrap())\n  Reviewed by: \(byline, color: .red)")
                        print("\(link, color: .cyan)")
                        print("\n")
                    }
                }
                sema.signal()
            }
            task.resume()

            sema.wait() // sets the process to wait
        }
    }
}
