//
//  ListNames.swift
//  
//
//  Created by Richard Mills on 10/3/20.
//

import Foundation

// NYTList.Names.manga.encoded

struct NYTList {
    enum Names: String, CaseIterable {
        case combinedPrintAndEBookFiction       = "Combined Print & E-Book Fiction"
        case combinecPrintAndEBookNonFiction    = "Combined Print & E-Book Nonfiction"
        case hardCoverFiction                   = "Hardcover Fiction"
        case hardCoverNonFiction                = "Hardcover Nonfiction"
        case tradeFictionPaperback              = "Paperback Trade Fiction"
        case paperbackNonFiction                = "Paperback Nonfiction"
        case adviceHowToAndMisc                 = "Advice, How-To & Miscellaneous"
        case childrensMiddleGradeHardcover      = "Children’s Middle Grade Hardcover"
        case childrensPictureBooks              = "Children’s Picture Books"
        case childrensSeries                    = "Children’s Series"
        case youngAdultHardcover                = "Young Adult Hardcover"
        case audioFictionMonthly                = "Audio Fiction - Monthly"
        case audioNonFictionMonthly             = "Audio Nonfiction - Monthly"
        case businessMonthly                    = "Business - Monthly"
        case graphicBooksAndMangaMonthly        = "Graphic Books and Manga - Monthly"
        case healthMonthly                      = "Health - Monthly"
        case massMarketMonthly                  = "Mass Market - Monthly"
        case middleGradePaperbackMonthly        = "Middle Grade Paperback - Monthly"
        case youngAdultPaperbackMonthly         = "Young Adult Paperback - Monthly"
        
        var encoded: String {
            switch self {
            case .combinedPrintAndEBookFiction:     return "combined-print-and-e-book-fiction"
            case .combinecPrintAndEBookNonFiction:  return "combined-print-and-e-book-nonfiction"
            case .hardCoverFiction:                 return "hardcover-fiction"
            case .hardCoverNonFiction:              return "hardcover-nonfiction"
            case .tradeFictionPaperback:            return "trade-fiction-paperback"
            case .paperbackNonFiction:              return "paperback-nonfiction"
            case .adviceHowToAndMisc:               return "advice-how-to-and-miscellaneous"
            case .childrensMiddleGradeHardcover:    return "childrens-middle-grade-hardcover"
            case .childrensPictureBooks:            return "picture-books"
            case .childrensSeries:                  return "series-books"
            case .youngAdultHardcover:              return "young-adult-hardcover"
            case .audioFictionMonthly:              return "audio-fiction"
            case .audioNonFictionMonthly:           return "audio-nonfiction"
            case .businessMonthly:                  return "business-books"
            case .graphicBooksAndMangaMonthly:      return "graphic-books-and-manga"
            case .healthMonthly:                    return "health"
            case .massMarketMonthly:                return "mass-market-monthly"
            case .middleGradePaperbackMonthly:      return "middle-grade-paperback-monthly"
            case .youngAdultPaperbackMonthly:       return "young-adult-paperback-monthly"
            }
        }
    }
}
