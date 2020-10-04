//
//  Utility.swift
//  
//
//  Created by Richard Mills on 10/3/20.
//

import Foundation
extension String {
    func truncated() -> Substring {
        return prefix(20)
    }
    
    public func wrap(columns: Int = 80) -> String {
        let scanner = Scanner(string: self)
        
        var result = ""
        var currentLineLength = 0
        
        var word: NSString?
        while scanner.scanUpToCharacters(from: NSMutableCharacterSet.whitespaceAndNewline() as CharacterSet, into: &word), let word = word {
            let wordLength = word.length
            
            if currentLineLength != 0 && currentLineLength + wordLength + 1 > columns {
                // too long for current line, wrap
                result += "\n"
                currentLineLength = 0
            }
            
            // append the word
            if currentLineLength != 0 {
                result += " "
                currentLineLength += 1
            }
            result += word as String
            currentLineLength += wordLength
        }
        
        return result
    }
}
