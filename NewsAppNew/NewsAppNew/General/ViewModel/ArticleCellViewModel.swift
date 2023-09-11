//
//  ArticleCellViewModel.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 05.09.2023.
//

import Foundation

class ArticleCellViewModel: TableCollectionViewItemProtocol {
    let title: String
    let description: String
    let date: String
    let imageUrl: String
    var imageData: Data?
    
    init(article: ArticleResponseObject) {
        title = article.title
        description = article.description ?? ""
        date = article.date
        imageUrl = article.urlToImage ?? ""
    }
}
