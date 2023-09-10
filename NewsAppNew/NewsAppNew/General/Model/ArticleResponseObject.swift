//
//  ArticleResponseObject.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 05.09.2023.
//

import Foundation

struct ArticleResponseObject: Codable {
    let title: String
    let description: String?
    let urlToImage: String?
    let date: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case description
        case urlToImage
        case date = "publishedAt" //тут мы дела задаем row value что бы привести к такому же имени как и в JSON файле
    }
}
