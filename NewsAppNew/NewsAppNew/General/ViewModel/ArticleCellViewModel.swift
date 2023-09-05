//
//  ArticleCellViewModel.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 05.09.2023.
//

import Foundation

struct ArticleCellViewModel {
    let title: String
    let description: String
    let date: String
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description
        date = article.publishedAt
    }
}
