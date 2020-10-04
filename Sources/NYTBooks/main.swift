//
//  main.swift
//
//
//  Created by Richard Mills on 10/3/20.
//

import Foundation
import ArgumentParser
import Chalk
import SwiftyJSON
import SwiftyTextTable

struct NYTBooks: ParsableCommand {
    static let configuration = CommandConfiguration(
        commandName:"nytb",
        abstract: "CLI to interact with the NYT book list",
        subcommands: [List.self, Review.self, Overview.self])

    init() { }
    
    static func getApiKey() throws -> String {
        guard let key = ProcessInfo.processInfo.environment["NYT_BOOK_API"] else {
            throw ValidationError("\("API Key not found", color: .magenta)")
        }
        return key
    }
}

NYTBooks.main()
