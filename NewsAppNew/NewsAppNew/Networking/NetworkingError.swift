//
//  NetworkingError.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 05.09.2023.
//

import Foundation

enum NetworkingError: Error {
    
case networkingError(_ error: Error)
case unknown
    
}
