//
//  NetworkManager.swift
//  PizzaYahoo
//
//  Created by Айдар Оспанов on 11.08.2023.
//

import Foundation

enum Link {
    case classification
    case food
    
    var url: URL {
        switch self {
        case .classification:
            return URL(
                string: "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
            )!
        case .food:
            return URL(
                string: "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
            )!
        }
    }
}

enum NetworkError: Error {
    case noData
    case invalidURL
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let dataModel = try decoder.decode(T.self, from: data)
                completion(.success(dataModel))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.decodingError))
            return
        }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}
