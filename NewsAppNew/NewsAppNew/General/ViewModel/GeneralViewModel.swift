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
    var reloadCell: ((Int) -> Void)? { get set }
    var numberOfCells: Int { get }
    var showError: ((String) -> Void)? { get set }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
}

final class GeneralViewModel: GeneralViewModelProtocol {
    
    //MARK: - Properties
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    var numberOfCells: Int {
        articles.count
    }
    //массив который хранит все новости
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    init() {
        loadData()
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        
        return articles[row]
    }
    
    private func loadData() {
        
        ApiManager.getNews { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.articles = self.convertToCellViewModel(articles: articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    private func convertToCellViewModel(articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0) }
    }
    private func loadImage() {
        
        for (index, article) in articles.enumerated() {
            ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                
                DispatchQueue.main.async {
                    switch result {
                    case .success(let data):
                        self?.articles[index].imageData = data
                        self?.reloadCell?(index)
                    case .failure(let error):
                        self?.showError?(error.localizedDescription)
                    }
                }
            }
        }
    }
    private func setUpMockOblect() {
        articles = [
            ArticleCellViewModel(article: ArticleResponseObject(title: "News number 1", description: "It's mainly a convenience endpoint that you can u", urlToImage: "...", date: "21.02.2023"))
        ]
    }
}
