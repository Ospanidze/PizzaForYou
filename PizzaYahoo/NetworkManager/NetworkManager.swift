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
    
    private let cacheModel = NSCache<NSString, AnyObject>()
    private let cacheImage = NSCache<NSString, CachedImage>()
    
    private init() {}
    
    func fetch<T: Decodable>(_ type: T.Type, from url: URL, completion: @escaping(Result<T, NetworkError>) -> Void) {
        
        if let cachedData = cacheModel.object(forKey: url.absoluteString as NSString) as? T {
            completion(.success(cachedData))
            return
            
        }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No Error description")
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let dataModel = try decoder.decode(T.self, from: data)
                self.cacheModel.setObject(
                    dataModel as AnyObject, forKey: url.absoluteString as NSString
                )
                completion(.success(dataModel))
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func fetchImage(from urlString: String, completion: @escaping(Result<Data,NetworkError>) -> Void) {
        
        if let cachedImage = cacheImage.object(forKey: urlString as NSString) {
            completion(.success(cachedImage.data))
            return
        }
        
        guard let url = URL(string: urlString) else {
            completion(.failure(.decodingError))
            return
        }

        let requestURL = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 5)
        
        guard let urlFromRequest = requestURL.url else { return }
        
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: urlFromRequest) else {
                completion(.failure(.noData))
                return
            }
            
            let cachedImageData = CachedImage(data: imageData)
            self.cacheImage.setObject(cachedImageData, forKey: urlString as NSString)
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
}

class CachedImage {
    let data: Data

    init(data: Data) {
        self.data = data
    }
}
