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
    var showError: ((String) -> Void)? { get set }
    var articles: [TableCollectionViewSection] { get }
    
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    
    private(set) var articles: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
  
     func loadData() {
        
         ApiManager.getNews(from: .business) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let articles):
                self.convertToCellViewModel(articles: articles)
                self.loadImage()
            case .failure(let error):
                DispatchQueue.main.async {
                    self.showError?(error.localizedDescription)
                }
            }
        }
    }
    private func loadImage() {
        for (i, section) in articles.enumerated() {
            for (index, item) in section.items.enumerated() {
                guard let article = item as? ArticleCellViewModel else { return }
                
                ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            if let article = self?.articles[i].items[index] as? ArticleCellViewModel {
                                article.imageData = data
                            }
                            self?.reloadCell?(index)
                        case .failure(let error):
                            self?.showError?(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
    private func convertToCellViewModel(articles: [ArticleResponseObject]) {
        var viewModels =  articles.map { ArticleCellViewModel(article: $0) }
        
        let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
        let secondSection = TableCollectionViewSection(items: viewModels)
        
        self.articles = [firstSection, secondSection]
    }
}
