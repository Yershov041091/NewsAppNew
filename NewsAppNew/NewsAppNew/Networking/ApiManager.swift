//
//  ApiManager.swift
//  NewsAppNew
//
//  Created by Artem Yershov on 05.09.2023.
//

import Foundation

final class ApiManager {
    enum Category: String {
        case business = "business"
        case general = "general"
        case technology = "technology"
    }
    private static let apiKey = "40e158280cbc4512827781fe8247f086"
    private static let baseUrl = "https://newsapi.org/v2/"
    private static let path = "top-headlines"
    
    static func getNews(from category: Category,
                        complition: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        
        let stringUrl = baseUrl + path + "?category=\(category.rawValue)&language=en" + "&apiKey=\(apiKey)"
        
        guard let url = URL(string: stringUrl) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            handleResponse(data: data, error: error, complition: complition)
        }
        //вызов этотго метода отправляет запрос в интернет
        session.resume()
    }
    static func getImageData(url: String, completion: @escaping (Result<Data, Error>) -> ()) {
        guard let url = URL(string: url) else { return }
        
        let session = URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                completion(.success(data))
            }
            if let error = error {
                completion(.failure(error))
            }
        }
        session.resume()
    }
    //функция которая обрабатывает ответ
    private static func handleResponse(data: Data?, error: Error?, complition: @escaping (Result<[ArticleResponseObject], Error>) -> ()) {
        if let error = error {
            complition(.failure(NetworkingError.networkingError(error)))
        } else if let data = data {
            let json = try? JSONSerialization.jsonObject(with: data)
            print(json ?? "")
            do {
                let model = try JSONDecoder().decode(NewsResponseObject.self, from: data)
                complition(.success(model.articles))
            }
            catch let decodeError {
                complition(.failure(decodeError))
            }
        } else {
            complition(.failure(NetworkingError.unknown))
        }
    }
}
