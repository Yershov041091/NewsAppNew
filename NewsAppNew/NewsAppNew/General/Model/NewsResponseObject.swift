//
//  NewsResponseObject.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 05.09.2023.
//

import Foundation

struct NewsResponseObject: Codable {
    let totalResults: Int
    let articles: [ArticleResponseObject]
    
    //это еужно для тогоб что бы декодировать наш JSON file
    enum CodingKeys: CodingKey {
        case totalResults
        case articles
    }
}
