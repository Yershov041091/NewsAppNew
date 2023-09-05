//
//  GeneralViewModel.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 04.09.2023.
//

import Foundation

protocol GeneralViewModelProtocol {
    //замыкание которое отвечает за перезагрузку стр после получения данных из интернета
    var reloadData: (() -> Void)? { get set }
    var numberOfCells: Int { get }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    
    //MARK: - Properties
    var reloadData: (() -> Void)?
    var numberOfCells: Int {
        articles.count
    }
    //массив который хранит все новости
    private var articles: [ArticleResponseObject] = [] {
        didSet {
            reloadData?()
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        let article = articles[row]
        
        return ArticleCellViewModel(article: article)
    }
    
    private func loadData() {
        //TODO: - load data
        
        setUpMockOblect()
    }
    private func setUpMockOblect() {
        articles = [
        ArticleResponseObject(title: "News number 1", description: "It's mainly a convenience endpoint that you can u", urlToImage: "...", publishedAt: "21.02.2023"),
        ArticleResponseObject(title: "News number 2", description: "It's mainly a convenience endpoint that you can u", urlToImage: "...", publishedAt: "21.02.2023"),
        ArticleResponseObject(title: "News number 3", description: "It's mainly a convenience endpoint that you can u", urlToImage: "...", publishedAt: "21.02.2023"),
        ArticleResponseObject(title: "News number 4", description: "It's mainly a convenience endpoint that you can u", urlToImage: "...", publishedAt: "21.02.2023"),
        ArticleResponseObject(title: "News number 5", description: "It's mainly a convenience endpoint that you can u", urlToImage: "...", publishedAt: "21.02.2023")
        ]
    }
}
