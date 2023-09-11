//
//  TableCollectionViewSection.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 10.09.2023.
//

import Foundation

protocol TableCollectionViewItemProtocol {
    
}

struct TableCollectionViewSection {
    var title: String?
    var items: [TableCollectionViewItemProtocol]
}
