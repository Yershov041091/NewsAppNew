//
//  BusinessViewModel.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 07.09.2023.
//

import Foundation

protocol BusinessViewModelProtocol {
    var reloadData: (() -> Void)? { get set }
    var reloadCell: ((Int) -> Void)? { get set }
    var numberOfCells: Int { get }
    var showError: ((String) -> Void)? { get set }
    
    func getArticle(for row: Int) -> ArticleCellViewModel
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    
    
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var numberOfCells: Int {
        articles.count
    }
    var showError: ((String) -> Void)?
    
    private var articles: [ArticleCellViewModel] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    
    func getArticle(for row: Int) -> ArticleCellViewModel {
        return articles[row]
    }
  
     func loadData() {
        
         ApiManager.getNews(from: .business) { [weak self] result in
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
    private func convertToCellViewModel(articles: [ArticleResponseObject]) -> [ArticleCellViewModel] {
        return articles.map { ArticleCellViewModel(article: $0) }
    }
}
