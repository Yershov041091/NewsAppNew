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
    var sections: [TableCollectionViewSection] { get }
    
    func loadData()
}

final class BusinessViewModel: BusinessViewModelProtocol {
    var reloadData: (() -> Void)?
    var reloadCell: ((Int) -> Void)?
    var showError: ((String) -> Void)?
    
    private(set) var sections: [TableCollectionViewSection] = [] {
        didSet {
            DispatchQueue.main.async {
                self.reloadData?()
            }
        }
    }
    private var page = 0
  
     func loadData() {
        page += 1
         
         ApiManager.getNews(from: .business, page: page) { [weak self] result in
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
        for (i, section) in sections.enumerated() {
            for (index, item) in section.items.enumerated() {
                guard let article = item as? ArticleCellViewModel else { return }
                
                ApiManager.getImageData(url: article.imageUrl) { [weak self] result in
                    
                    DispatchQueue.main.async {
                        switch result {
                        case .success(let data):
                            if let article = self?.sections[i].items[index] as? ArticleCellViewModel {
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
        
        if sections.isEmpty {
            let firstSection = TableCollectionViewSection(items: [viewModels.removeFirst()])
            let secondSection = TableCollectionViewSection(items: viewModels)
            
            sections = [firstSection, secondSection]
        } else {
            sections[1].items += viewModels
        }
    }
}
