//
//  NetworkManager.swift
//  ItunesPlus
//
//  Created by iYezan on 27/02/2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    let baseURL = URL(string: "https://itunes.apple.com/search")!
    
    
    
    func getItems(matching  query: [String: String], completion: @escaping ([StoreItem]?) -> Void) {
        
        let url = baseURL.withQueries(query)!
        
        let task = URLSession.shared.dataTask(with: url) { data, response, err in
            let jsonDecoder = JSONDecoder()
            
            if let data = data,
               let storeItems = try? jsonDecoder.decode(StoreItems.self, from: data) {
                completion(storeItems.results)
            } else {
                print("Either no data was returned, or data was not serialized.")
                completion(nil)
            }
        }
        task.resume()
    }
}

extension URL {
    func withQueries(_ queries: [String: String]) -> URL? {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
