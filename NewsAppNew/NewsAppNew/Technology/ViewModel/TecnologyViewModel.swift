//
//  TecnologyViewModel.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 10.09.2023.
//

import Foundation

final class TecnologyViewModel: NewsListViewModel {
     override func loadData() {
         super.loadData()
        
         ApiManager.getNews(from: .technology, page: page) { [weak self] result in
             self?.handleResult(result)
        }
    }
    override func convertToCellViewModel(articles: [ArticleResponseObject]) {
        var viewModels =  articles.map { ArticleCellViewModel(article: $0) }
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
}
